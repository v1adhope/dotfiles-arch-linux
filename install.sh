#!/usr/bin/env bash

# === Attention please!!! ===
# Comment/uncomment the groups and functions you want
#
# Use install_paru function if you have not paru
#
# Recommending pacstrap pkgs: base base-devel linux-zen linux-zen-headers
#                          linux-firmware btrfs-progs vim git grub
#                          efibootmgr dhcpcd dhclient networkmanager man-db
#                          openssh os-prober
#
# A reboot is required after installation

# === Supporting ===
local_path=$HOME/.local
config_path=$HOME/.config
dotfiles_path=$local_path/dotfiles-arch-linux

DEFAULT="\033[0m"
# Bold font below
BLUE="\033[1;94m"
MAGENTA="\033[1;95m"
GREEN="\033[1;92m"
RED="\033[1;91m"

function print_error {
    echo -e "${RED}==>${DEFAULT} Something went wrong\n"
}

function print_complete {
    echo -e "${GREEN}==>${DEFAULT} Task completed\n"
}

function print_func_prompt {
  printf "${MAGENTA}==>${DEFAULT} %s\n" "${PROMPT}"

}

function print_info_prompt {
  printf "${BLUE}==>${DEFAULT} %s\n%s\n\n" "${PROMPT}" "${VALUE}"
}

# === Pre functions ===
function enable_TRIM {
  PROMPT="Enabling TRIM..."
  print_func_prompt

  sudo systemctl enable fstrim.timer
  if [ 0 != $? ]; then
    print_error
    return
  fi

  print_complete
}

function install_paru {
  PROMPT="Installation of the AUR paru manager..."
  print_func_prompt

  git clone --depth=1 https://aur.archlinux.org/paru-bin.git .cache/paru
  if [ 0 != $? ]; then
    print_error
    return
  fi

  cd .cache/paru && makepkg -si
  if [ 0 != $? ]; then
    print_error
    return
  fi

  cd .. && rm -rf paru

  print_complete
}

function mirror_generation {
  PROMPT="Mirror generation..."
  print_func_prompt

  paru -S reflector
  if [ 0 != $? ]; then
    print_error
    return
  fi

  sudo reflector --latest 15 --protocol https --country US,DE,FR \
                 --sort rate --save /etc/pacman.d/mirrorlist
  if [ 0 != $? ]; then
    print_error
    return
  fi

  paru
  if [ 0 != $? ]; then
    print_error
    return
  fi

  print_complete
}

function refresh_keyring {
  PROMPT="Keychain update..."
  print_func_prompt

  sudo pacman-key --init
  if [ 0 != $? ]; then
    print_error
    return
  fi

  sudo pacman-key --populate archlinux
  if [ 0 != $? ]; then
    print_error
    return
  fi

  sudo pacman-key --refresh-keys
  if [ 0 != $? ]; then
    print_error
    return
  fi

  print_complete
}

function install_zen_core_tweaks {
  PROMPT="Installing tweaks to the linux zen kernel..."
  print_func_prompt

  paru -S cfs-zen-tweaks
  if [ 0 != $? ]; then
    print_error
    return
  fi

  sudo systemctl enable --now set-cfs-tweaks.service
  if [ 0 != $? ]; then
    print_error
    return
  fi

  print_complete
}

function install_irqbalance {
  PROMPT="Installing irqbalance..."
  print_func_prompt

  paru -S irqbalance
  if [ 0 != $? ]; then
    print_error
    return
  fi

  sudo systemctl enable --now irqbalance.service
  if [ 0 != $? ]; then
    print_error
    return
  fi

  print_complete
}

#TRIM_enable

#install_paru

#mirror_generation

# Recomending after mirror_generation
#refresh_keyring

#install_zen_core_tweaks

# Unknown impact
#install_irqbalance

# === Choosing packages, configs ===
PKGLIST=()
CONFIGS=()

# AMD build (optional)
# See gpu_undervolt
#GPU/2D/3D rendering # Hardware video acceleration x64
#PKGLIST+=(amd-ucode mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
#          vulkan-icd-loader lib32-vulkan-icd-loader xf86-video-amdgpu \
#          libva-mesa-driver mesa-vdpau amdgpu-fan)

# Intel CPU only build (optional)
#PKGLIST+=(mesa lib32-mesa vulkan-intel lib32-vulkan-intel itel-media-driver libva-utils)

# Fonts (see setup_fonts)
#PKGLIST+=(ttf-hack-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk)

# Console and navigation
#PKGLIST+=(alacritty zsh tmux exa bat nnn fd ripgrep)
#CONFIGS+=(alacritty tmux bat git)

# Widget tool kits
#PKGLIST+=(gtk3 gtk4 libayatana-appindicator libappindicator-gtk3 adwaita-qt5 adwaita-qt6)

# Audio stack
#PKGLIST+=(pipewire lib32-pipewire wireplumber pipewire-audio pipewire-alsa \
#          pipewire-pulse pipewire-jack-client jack2 lib32-jack2 \
#          playerctl bluez-utils noise-suppression-for-voice)
#CONFIGS+=(pipewire)

# Counting
#PKGLIST+=(homebank)

# GUI (required alacritty, qtk, audio stack)
#PGKLIST+=(xorg-server xorg-xwayland xdg-desktop-portal-hyprland \
#          hyprland hyprland-qtutils fuzzel waybar mako hypridle hyprlock hyprpaper \
#          grim slurp)
#CONFIGS+=(hypr fuzzel waybar mako)

# Software
#PKGLIST+=(firefox telegram-desktop keepassxc qbittorrent \
#          obsidian dropbox libreoffice-still imv mpv sioyek-git)
#CONFIGS+=(mpv imv sioyek)

#PKGLIST+=(filezilla chromium clipgrab webcord gimp-devel audacity)

# Dev
#PKGLIST+=(glow npm nvm neovim python-pip ruff lazygit stylua eslint yarn wget)
#CONFIGS+=(nvim)

#PKGLIST+=(php rust)

#PKGLIST+=(go gopls go-tools delve golangci-lint ko)

#PKGLIST+=(rustup)

#PKGLIST+=(docker docker-compose docker-buildx)

#PKGLIST+=(dotnet-host dotnet-runtime dotnet-sdk aspnet-runtime)
#PKGLIST+=(dotnet-runtime-7.0 dotnet-sdk-7.0 aspnet-runtime-7.0 \
#          dotnet-runtime-6.0 dotnet-sdk-6.0 aspnet-runtime-6.0 \
#          mono dotnet-runtime-3.0 dotnet-sdk-3.0 aspnet-runtime-3.0)

#PKGLIST+=(apache testssl.sh insomnia postgresql-libs go-task goreleaser)

# Useful tools
#PKGLIST+=(mesa-utils vulkan-tools nvtop xorg-xeyes  \
#          smbclient pacman-contrib ninja cups samsung-unified-driver-printer \
#          ffmpegthumbnailer ascii rsync tldr love)

#PKGLIST+=(htop inxi fastfetch cronie wl-clipboard xorg-xeyes \
#          android-sdk-platform-tools pacman-contrib rsync\
#          jre8-openjdk jre-openjdk hunspell-en_us hunspell-ru jq viu ascii \
#          ffmpegthumbnailer zip unzip exfat-utils dosfstools \
#          libnotify numbat perl-file-mimeinfo)

# Video-Cam
#PKGLIST=(scrcpy v4l2loopback-dkms obs-studio obs-vkcapture lib32-obs-vkcapture)

# Games
# Bug https://github.com/ValveSoftware/steam-for-linux/issues/9083
#PKGLIST+=(steam mangohud lib32-mangohud xpadneo-dkms)
#CONFIGS+=(mangohud)

# === Packages installation ===
# Required paru
PROMPT="Packages list"; VALUE="${PKGLIST[*]}"
print_info_prompt
paru -S ${PKGLIST[@]}

# === Create link configs ===
function link_configs {
  for config in ${CONFIGS[@]}; do
    ln -sf $dotfiles_path/$config $config_path
  done
}

PROMPT="Configs list"; VALUE="${CONFIGS[*]}"
print_info_prompt
link_configs

# Manual mapping
#ln -sf $dotfiles_path/widget-toolkits/gtk-3.0 $config_path
#mkdir -p  $config_path/chromium && ln -sf $dotfiles_path/chromium/chromium-flags.conf $config_path/chromium/chromium-flags.conf
#mkdir -p  $config_path/nnn && ln -sf $dotfiles_path/nnn/customize.sh $config_path/nnn/customize.sh
#ln -sf $dotfiles_path/vim/.vimrc $HOME
#ln -sf $dotfiles_path/zsh/.zshrc $HOME
#ln -sf $dotfiles_path/scripts $local_path

function unlink_configs {
  for config in ${CONFIGS[@]}; do
    unlink $config_path/$config
  done

  #unlink $config_path/gtk-3.0
  #unlink $config_path/chromium/chromium-flags.conf
  #unlink $config_path/nnn/customize.sh
  #unlink $HOME/.vimrc
  #unlink $HOME/.zshrc
  #unlink $local_path/scripts
}

#unlink_configs

# === Fixes and automation ===
function settings {
  PROMPT="Make the necessary adjustments..."
  print_func_prompt

  for i in ${PKGLIST[@]}; do
    case $i in
      "dropbox")
        # Dropbox fix
        rm -rf ~/.dropbox-dist
        install -dm0 ~/.dropbox-dist
      ;; "bluez-utils")
        # Enable bluetooth
        rfkill unblock bluetooth
        sudo systemctl enable --now bluetooth.service
      ;; "zsh")
        # ZSH as default shell
        chsh -s /bin/zsh
      ;; "pipewire")
        # Use for immediate application pipewire
        systemctl restart --user pipewire.service
        systemctl --user daemon-reload
      ;; "docker")
        sudo usermod -aG docker $USER
        newgrp docker
    esac
  done
}

# Necessarily for first use
#settings

# === Post functions ===
function create_GRUB_cfg_link {
  sudo ln -sf $dotfiles_path/grub/grub /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}

function gpu_undervolt {
  ./gpu-undervolt/undervolt-rx5700xt.sh
}

function create_pacman_cfg_link {
  sudo ln -sf $dotfiles_path/pacman/pacman.conf /etc/pacman.conf
}

function setup_fonts {
  sudo ln -sf $dotfiles_path/fonts/local.conf /etc/fonts/local.conf
  fc-cache
}

function init_rust {
  rustup default stable
  rustup toolchain install stable
}

#create_GRUB_cfg_link

#create_pacman_cfg_link

#gpu_undervolt

#setup_fonts

#init_rust



# TODO: fix
function set_up_NetworkManager {
  systemctl enable --now systemd-networkd
  systemctl enable --now systemd-resolved
  #sudo rm -rf /etc/NetworkManager/conf.d
  #sudo ln -sf networkmanager/conf.d /etc/NetworkManager
}

# TODO: up to date
function create_BtH_cfg_link {
  echo "TODO"
  #sudo stow --adopt -t /etc/bluetooth bluetooth-stack
}

#set_up_NetworkManager

#create_BtH_cfg_link

# Mimetypes
#TODO: system overwrites the file
#cat mimetype/.config/mimeapps.list > $HOME/.config/mimeapps.list

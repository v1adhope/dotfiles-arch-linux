#!/bin/bash

# TODO:
# fix schemastore

### Attention please!!!
#
# Comment/uncomment the groups and functions you want
#
# Use install_paru function if you have not paru
#
# recommend pacstrap pkgs: base base-devel linux-zen linux-zen-headers
#                          linux-firmware btrfs-progs vim git grub
#                          efibootmgr dhcpcd dhclient networkmanager man-db
#
# A reboot is required after installation

DEFAULT="\033[0m"
BLUE="\033[1;94m" # BOLD
MAGENTA="\033[1;95m" # BOLD
GREEN="\033[1;92m" # BOLD
RED="\033[1;91m" #BOLD

function print_error {
    echo -e "${RED}==>${DEFAULT} Something went wrong\n"
}
#
function print_complete {
    echo -e "${GREEN}==>${DEFAULT} Task completed\n"
}
#
function print_func_prompt {
  printf "${MAGENTA}==>${DEFAULT} %s\n" "${PROMPT}"

}
#
function print_info_prompt {
  printf "${BLUE}==>${DEFAULT} %s\n%s\n\n" "${PROMPT}" "${VALUE}"
}

### Functions
#
function TRIM_enable {
  PROMPT="Enabling TRIM..."
  print_func_prompt

  sudo systemctl enable fstrim.timer
  if [ 0 != $? ]; then
    print_error
    return
  fi

  print_complete
}
#
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
#
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
#
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
#
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
#
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
#
# TRIM_enable
#
# install_paru
#
# mirror_generation
#
# NOTE: Is recomended after mirror_generation
# refresh_keyring
#
# install_zen_core_tweaks
#
# install_irqbalance

### Choosing packages, configs
#
PKGLIST=()
CONFIGS=()
#
# AMD # GPU/2D/3D rendering # Hardware video acceleration x64
# PKGLIST+=(amd-ucode mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
#         vulkan-icd-loader lib32-vulkan-icd-loader xf86-video-amdgpu \
#         libva-mesa-driver mesa-vdpau)
#
# Video-Cam
# PKGLIST=(scrcpy v4l2loopback-dkms obs-studio obs-vkcapture lib32-obs-vkcapture)
#
# Games
# BUG: https://github.com/ValveSoftware/steam-for-linux/issues/9083
# PKGLIST+=(steam mangohud lib32-mangohud xpadneo-dkms)
# STOWLIST+=(mangohud)
#
# TODO: Utilities
# PKGLIST+=(mesa-utils vulkan-tools htop nvtop inxi xorg-xeyes \
#           wireguard-tools neofetch nnn cronie wl-clipboard smbclient \
#           perl-file-mimeinfo android-sdk-platform-tools pacman-contrib \
#           ninja cups samsung-unified-driver-printer java-openjfx-src \
#           jre8-openjdk hunspell-en_us hunspell-ru xdg-desktop-portal jq viu \
#           ffmpegthumbnailer glow zip unzip exfat-utils dosfstools ascii \
#           grim slurp rsync libva-utils)
# STOWLIST+=(nnn)
#
# TODO: Software
# BUG: Telegream coredump: https://gitlab.freedesktop.org/mesa/mesa/-/issues/7754
# PKGLIST+=(filezilla keepassxc firefox telegram-desktop qbittorrent \
#           clipgrab authy google-chrome obsidian dropbox webcord \
#           gimp-devel audacity imv libreoffice-still mpv sioyek)
# STOWLIST+=(google-chrome imv mpv sioyek)

# INFO: There is moved to hyprland
# PKGLIST+=(sway swaybg swayidle swaylock waybar mako fuzzel \
#           xdg-desktop-portal-wlr-git xorg-server xorg-xwayland)
# CONFIGS+=(sway waybar mako fuzzel swaylock)

PKGLIST+=(vim neovim go docker docker-compose docker-buildx apache testssl.sh npm rust insomnium-bin)
CONFIGS+=(nvim)
# ln -sf $HOME/.local/dotfiles-arch-linux/vim/.vimrc $HOME
# unlink $HOME/.vimrc

PGKLIST+=(xorg-server xorg-xwayland xdg-desktop-portal-hyprland \
          hyprland fuzzel waybar mako swayidle swaylock hyprpaper)
CONFIGS+=(hypr fuzzel waybar mako swaylock)

PKGLIST+=(alacritty zsh tmux exa bat nnn)
CONFIGS+=(alacritty tmux bat)
# ln -sf $HOME/.local/dotfiles-arch-linux/zsh/.zshrc $HOME
# unlink $HOME/.zshrc
# ln -sf $HOME/.local/dotfiles-arch-linux/scripts $HOME/.local
# unlink $HOME/.local/scripts
# ln -sf $HOME/.local/dotfiles-arch-linux/nnn/customize.sh $HOME/.config/nnn/customize.sh
# unlink $HOME/.config/chromium/chromium-flags.conf

PKGLIST+=(ttf-hack-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk)

PKGLIST+=(chromium telegram-desktop keepassxc qbittorrent \
          authy obsidian dropbox libreoffice-still imv mpv sioyek)
CONFIGS+=(mpv imv git sioyek)
# ln -sf $HOME/.local/dotfiles-arch-linux/chromium/chromium-flags.conf $HOME/.config/chromium/chromium-flags.conf
# unlink $HOME/.config/chromium/chromium-flags.conf

PKGLIST+=(gtk3 gnome-themes-extra qgnomeplatform-qt5 qgnomeplatform-qt6)
# ln -sf $HOME/.local/dotfiles-arch-linux/widget-toolkits/gtk-3.0 $HOME/.config
# unlink $HOME/.config/gtk-3.0

PKGLIST+=(pipewire lib32-pipewire wireplumber pipewire-alsa \
          pipewire-pulse pipewire-jack lib32-pipewire-jack playerctl \
          bluez-utils noise-suppression-for-voice)
CONFIGS+=(pipewire)
# ln -sf $HOME/.local/dotfiles-arch-linux/pipewire $HOME/.config
# unlink $HOME/.config/pipewire

PKGLIST+=(mesa lib32-mesa vulkan-intel lib32-vulkan-intel itel-media-driver libva-utils)

PKGLIST+=(htop inxi neofetch nnn cronie wl-clipboard xorg-xeyes \
          android-sdk-platform-tools pacman-contrib ninja rsync\
          jre8-openjdk hunspell-en_us hunspell-ru jq viu ascii \
          ffmpegthumbnailer glow zip unzip exfat-utils dosfstools \
          grim slurp libnotify fd)

PKGLIST+=(mesa-utils vulkan-tools htop nvtop inxi xorg-xeyes \
          wireguard-tools neofetch nnn cronie wl-clipboard smbclient \
          perl-file-mimeinfo android-sdk-platform-tools pacman-contrib \
          ninja cups samsung-unified-driver-printer java-openjfx-src \
          jre8-openjdk hunspell-en_us hunspell-ru xdg-desktop-portal jq viu \
          ffmpegthumbnailer glow zip unzip exfat-utils dosfstools ascii \
          grim slurp rsync libva-utils)

PKGLIST+=(filezilla keepassxc firefox telegram-desktop qbittorrent \
          clipgrab authy google-chrome obsidian dropbox webcord \
          gimp-devel audacity imv libreoffice-still mpv sioyek)

### Install packages
#
PROMPT="Packages list"; VALUE="${PKGLIST[*]}"
print_info_prompt
paru -S ${PKGLIST[@]}

### Create link configs
#
local_path=$HOME/.local
config_path=$HOME/.config
root_path=$local_path/dotfiles-arch-linux
#
PROMPT="Configs list"; VALUE="${CONFIGS[*]}"
print_info_prompt
#
function link_configs {
  for config in ${CONFIGS[@]}; do
    ln -sf $root_path/$config $config_path
  done

  # ln -sf $root_path/zsh/.zshrc $HOME
  # ln -sf $root_path/scripts $local_path
}
#
# link_configs
#
function unlink_configs {
  for config in ${CONFIGS[@]}; do
    unlink $config_path/$config
  done

  # unlink $HOME/.zshrc
  # unlink $HOME/.local/scripts
}
# unlink_configs

### Fixes and automation
#
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
#
# NOTE: Necessarily for first use
# settings

### NetworkManager
#
# sudo stow -t /etc/NetworkManager/conf.d/ networkmanager

### Fonts setup
#
function setup_fonts {
  sudo ln -sf $HOME/.local/dotfiles-arch-linux/fonts/local.conf /etc/fonts/local.conf
  fc-cache
}
#
# setup_fonts

### Create grub link config
#
function create_GRUB_cfg_link {
  sudo ln -sf $HOME/.local/dotfiles-arch-linux/grub/grub /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}
#
# create_GRUB_cfg_link

### Create pacman link config
#
function create_pacman_cfg_link {
  sudo ln -sf $HOME/.local/dotfiles-arch-linux/pacman/pacman.conf /etc/pacman.conf
}
#
# create_pacman_cfg_link

### TODO: Create bluetooth link config
#
function create_BtH_cfg_link {
  sudo stow --adopt -t /etc/bluetooth bluetooth-stack
}
#
# create_BtH_cfg_link

### Mimetype TODO: system overwrites the file
#
# cat mimetype/.config/mimeapps.list > $HOME/.config/mimeapps.list

#!/bin/bash

### Attention please!!!
#
# Comment/uncomment the groups and functions you want
#
# Use install_paru function if you have not paru
#
# recommend pacstrap pkgs: base base-devel linux-zen linux-zen-headers \
#                          linux-lts linux-lts-headers linux-firmware \
#                          btrfs-progs vim git grub efibootmgr dhcpcd \
#                          dhclient networkmanager
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

function print_complete {
    echo -e "${GREEN}==>${DEFAULT} Task completed\n"
}

function print_func_prompt {
  printf "${MAGENTA}==>${DEFAULT} %s\n" "${PROMPT}"

}

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

  sudo reflector --latest 15 --protocol https --country DE,FR,US \
                 --sort rate --save /etc/pacman.d/mirrorlist
  if [ 0 != $? ]; then
    print_error
    return
  fi

  paru -Syu
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

### Choosing packages, configs, LSPs
#
PKGLIST=()
STOWLIST=()
# See dotfiles/install-lsp/ about available
LSPLIST+=(go lua)
#
# Common
PKGLIST+=(stow exa bat)
STOWLIST+=(git scripts)
#
# AMD
PKGLIST+=(amd-ucode)
#
# AMD GPU/2D/3D rendering
PKGLIST+=(mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
          vulkan-icd-loader lib32-vulkan-icd-loader xf86-video-amdgpu)
#
# Hardware video acceleration x64
PKGLIST+=(libva-mesa-driver mesa-vdpau)
#
# Terminal emulator
PKGLIST+=(alacritty)
STOWLIST+=(alacritty)
#
# Shell
PKGLIST+=(zsh)
STOWLIST+=(zsh)
#
# Multiplexer
PKGLIST+=(tmux)
STOWLIST+=(tmux)
#
# Fonts
PKGLIST+=(ttf-hack-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk)
#
# Widget toolkits
PKGLIST+=(gtk2 gtk3 qt5ct qt6ct adwaita-qt5 adwaita-qt6)
STOWLIST+=(gtk)
#
# Sway
PKGLIST+=(sway swaybg swayidle swaylock waybar mako fuzzel \
          xdg-desktop-portal-wlr xorg-server xorg-xwayland)
STOWLIST+=(sway waybar mako fuzzel swaylock)
#
# Audio-Voice
PKGLIST+=(pipewire lib32-pipewire wireplumber pipewire-alsa \
          pipewire-pulse pipewire-jack lib32-pipewire-jack playerctl \
          bluez-utils noise-suppression-for-voice)
STOWLIST+=(pipewire)
#
# Multimedia
PKGLIST+=(imv grim slurp flameshot libreoffice-still mpv gimp sioyek)
STOWLIST+=(imv mpv)
#
# Utilities
PKGLIST+=(mesa-utils vulkan-tools htop nvtop inxi xorg-xeyes \
          wireguard-tools neofetch nnn cronie wl-clipboard \
          perl-file-mimeinfo android-sdk-platform-tools pacman-contrib \
          ninja cups samsung-unified-driver-printer jre8-openjdk \
          hunspell-en_us hunspell-ru xdg-desktop-portal jq viu \
          ffmpegthumbnailer glow)
STOWLIST+=(nnn)
#
# Software
PKGLIST+=(filezilla keepassxc firefox telegram-desktop qbittorrent \
          clipgrab authy google-chrome obsidian dropbox webcord \
          obs-studio)
STOWLIST+=(google-chrome)
#
# DEV
PKGLIST+=(vim neovim go docker docker-compose)
STOWLIST+=(vim nvim)
#
# Games
PKGLIST+=(steam mangohud lib32-mangohud xpadneo-dkms)
STOWLIST+=(mangohud)

### Install packages
#
# NOTE: See 292 line
PROMPT="Packages list"; VALUE="${PKGLIST[*]}"
print_info_prompt
# paru -S ${PKGLIST[@]}

### Create link configs
#
PROMPT="Configs list"; VALUE="${STOWLIST[*]}"
print_info_prompt
# stow ${STOWLIST[@]}

### Install LSPs
#
PROMPT="LSP list"; VALUE="${LSPLIST[*]}"
print_info_prompt
#
function install_lsp {
  PROMPT="Installing LSP servers..."
  print_func_prompt

  for i in ${LSPLIST[@]}; do
    "./install-lsp/install-$i-lsp.sh"
  done
}
#
# install_lsp


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
    ;; "pipewire"
      # Use for immediate application pipewire
      systemctl restart --user pipewire.service
      systemctl --user daemon-reload
    ;;
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
  sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
  sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
  sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

  sudo sed -e '/export FREETYPE_PROPERTIES="truetype:interpreter-version=40"/s/^# *//' -i /etc/profile.d/freetype2.sh

  sudo stow -t /etc/fonts fonts
  fc-cache
}
#
# setup_fonts

### Create grub link config
#
function create_GRUB_cfg_link {
  sudo rm /etc/default/grub
  sudo stow -t /etc/default grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}
#
# create_GRUB_cfg_link

### Create bluetooth link config
#
function create_BtH_cfg_link {
  sudo rm /etc/bluetooth/main.conf
  sudo stow -t /etc/bluetooth bluetooth-stack
}
#
# create_BtH_cfg_link

### Mimetype TODO: system overwrites the file
#
# cat mimetype/.config/mimeapps.list > $HOME/.config/mimeapps.list

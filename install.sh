#!/bin/bash

### Attention please!!!
#
# Comment/uncomment the groups you want
# 
# Use install_paru function if you have not paru
#
# recommend pacstrap pkgs: base base-devel linux-zen linux-zen-headers linux-lts linux-lts-headers \
#                linux-firmware btrfs-progs vim git grub efibootmgr dhcpcd dhclient networkmanager
#
# A reboot is required after installation

function TRIM_enable {
  sudo systemctl enable fstrim.timer
}

function install_paru {
  git clone --depth=1 https://aur.archlinux.org/paru-bin.git 
  cd paru && makepkg -si
  cd .. && rm -rf paru
}

function mirror_generation {
  paru -S reflector
  sudo reflector --latest 15 --protocol https --country France --country Germany \
                 --sort rate --save /etc/pacman.d/mirrorlist
  paru -Syu
}

function refresh_keyring {
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
  sudo pacman-key --refresh-keys
  mirror_generation
}

function zen_core_tweaks {
  paru -S cfs-zen-tweaks
  sudo systemctl enable --now set-cfs-tweaks.service
}

### Functions
#
# TRIM_enable
#
# install_paru
#
# mirror_generation
#
## Include mirror_generation
# refresh_keyring
#
# zen_core_tweaks
 
### Choosing packages and configs
#
PKGLIST=()
STOWLIST=()
#
# Common
PKGLIST+=(stow)
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
PKGLIST+=(ttf-hack-nerd noto-fonts noto-fonts-emoji)
#
# Bluetooth support
PKGLIST+=(pulseaudio-bluetooth bluez-utils)
#
# Widget toolkits
PKGLIST+=(gtk2 gtk3 qt5ct qt6ct adwaita-qt5 adwaita-qt6)
STOWLIST+=(gtk)
#
# Sway
PKGLIST+=(sway swaybg swayidle swaylock waybar mako jq fuzzel xdg-desktop-portal-wlr \
          xorg-server xorg-xwayland)
STOWLIST+=(sway waybar mako fuzzel swaylock)
#
# Multimedia 
PKGLIST+=(vim vim-plug pulseaudio playerctl pipewire lib32-pipewire wireplumber imv \
          xdg-desktop-portal grim slurp flameshot jre8-openjdk libreoffice-still \
          hunspell-en_us hunspell-ru libreoffice-extension-languagetool mpv) 
STOWLIST+=(vim imv mpv)
#
# Utilities 
PKGLIST+=(mesa-utils vulkan-tools htop nvtop inxi xorg-xeyes wireguard-tools neofetch nnn \
          cronie wl-clipboard perl-file-mimeinfo)
STOWLIST+=(mimetype nnn)
#
# Software
PKGLIST+=(filezilla keepassxc firefox telegram-desktop qbittorrent clipgrab \
          authy google-chrome obsidian dropbox webcord obs-studio)
STOWLIST+=(google-chrome)
#
# Go
PKGLIST+=(go)
#
# SQL
# Postgres version 14
PKGLIST+=(postgresql)
#
# Games
PKGLIST+=(steam mangohud lib32-mangohud)
STOWLIST+=(mangohud)

### Install packages
#
echo ${PKGLIST[@]}
# paru -S ${PKGLIST[@]}

### Create link configs
#
echo ${STOWLIST[@]}
# stow ${STOWLIST[@]}

### Fixes and automation
#
function settings {
for i in ${PKGLIST[@]}; do
  if [ $i == "dropbox" ]
    then
      # Dropbox fix
      rm -rf ~/.dropbox-dist
      install -dm0 ~/.dropbox-dist 
  elif [ $i == "bluez-utils" ]
    then
      # Enable bluetooth
      rfkill unblock bluetooth
      sudo systemctl enable --now bluetooth.service
  elif [ $i == "zsh" ]
    then
      #  ZSH as default shell
      chsh -s /bin/zsh
  fi
done
}
#settings

### NetworkManager
# sudo stow -t /etc/NetworkManager/conf.d/ networkmanager #

### Fonts setup
# sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
# sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
# sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
#
# Uncomment export FREETYPE_PROPERTIES="truetype:interpreter-version=40" in /etc/profile.d/freetype2.sh
#
# sudo stow -t /etc/fonts fonts
# fc-cache

### Create grub link config
# sudo rm /etc/default/grub
# sudo stow -t /etc/default grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg

### Create bluetooth link config
# sudo rm /etc/bluetooth/main.conf
# sudo stow -t /etc/bluetooth bluetooth-stack


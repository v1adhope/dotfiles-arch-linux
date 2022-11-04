#!/bin/bash

### Attention please!!!
#
# Comment/uncomment the groups you want
# 
# recommend pacstrap pkgs: base base-devel linux-zen linux-zen-headers linux-lts linux-lts-headers \
#                linux-firmware btrfs-progs vim git grub efibootmgr dhcpcd dhclient networkmanager
#
# A reboot is required after installation
#
# Install paru
# git clone https://aur.archlinux.org/paru.git
# cd paru && makepkg -si
# cd .. && rm -rf paru
#
#
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
# Fonts
PKGLIST+=(ttf-hack-nerd noto-fonts noto-fonts-emoji)
#
# Bluetooth support
PKGLIST+=(pulseaudio-bluetooth bluez-utils)
#
# Widget toolkits
PKGLIST+=(gtk2 gtk3 gtk4)
STOWLIST+=(gtk)
#
# Sway
PKGLIST+=(sway swaybg swayidle swaylock waybar mako fuzzel xdg-desktop-portal-wlr \
          xorg-server xorg-xwayland)
STOWLIST+=(sway waybar mako fuzzel)
#
# Multimedia 
PKGLIST+=(vim pulseaudio playerctl pipewire lib32-pipewire wireplumber imv \
          xdg-desktop-portal grim flameshot jre8-openjdk libreoffice-still \
	  hunspell-en_us hunspell-ru libreoffice-extension-languagetool mpv) 
#
# Utilities 
PKGLIST+=(mesa-utils vulkan-tools htop nvtop inxi xorg-xeyes wireguard-tools neofetch nnn cronie)
#
# Software
PKGLIST+=(filezilla keepassxc firefox telegram-desktop qbittorrent clipgrab \
          authy google-chrome notion-app webcord)
STOWLIST+=(google-chrome)
#
# Go
PKGLIST+=(go)
#
# Games
PKGLIST+=(steam mangohud lib32-mangohud)
STOWLIST+=(mangohud)
#
### TRIM enable
# sudo systemctl enable fstrim.timer
#
### Refresh keyring(requires entropy)
# pacman-key --init
# pacman-key --populate archlinux
# pacman-key --refresh-keys
# sudo pacman -Sy
#
### Mirror generation
# paru -S reflector
# sudo reflector --latest 15 --protocol https --country France --country Germany \
#           --sort rate --save /etc/pacman.d/mirrorlist
# paru -Syyuu
#
### Install tweaks for arch zen core 
# paru -S cfs-zen-tweaks
# sudo systemctl enable --now set-cfs-tweaks.service
#
#
#
### Install
echo ${PKGLIST[@]}
# paru -S ${PKGLIST[@]}
#
### Create link configs
echo ${STOWLIST[@]}
# stow ${STOWLIST[@]}
#
#
#
### Set zsh shell
# chsh -s /bin/zsh
#
### Fonts setup
# sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
# sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
# sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
#
# Uncomment export FREETYPE_PROPERTIES="truetype:interpreter-version=40" in /etc/profile.d/freetype2.sh
#
# sudo stow -t /etc/fonts fonts
# fc-cache
#
### Bluetooth enable with simple settings 
# rfkill unblock bluetooth
# sudo systemctl enable -now bluetooth.service
# sudo rm /etc/bluetooth/main.conf
# sudo stow -t /etc/bluetooth bluetooth-stack

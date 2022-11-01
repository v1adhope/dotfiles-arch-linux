#!/bin/bash

### Attention please!!!
#
# Comment/uncomment the groups you want
#
# A reboot is required after installation
#
#
#
PKGLIST=()
STOWLIST=()
#
# Common
PKGLIST+=(git stow networkmanager)
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
PKGLIST+=(otf-font-awesome ttf-hack-nerd)
#
# Sway
PKGLIST+=(sway swaybg swayidle swaylock waybar mako fuzzel xdg-desktop-portal-wlr \
          xorg-server)
STOWLIST+=(sway waybar mako fuzzel)
#
# Multimedia 
PKGLIST+=(vim pulseaudio bluez playerctl pipewire lib32-pipewire wireplumber imv \
          xdg-desktop-portal grim flameshot jre8-openjdk libreoffice-still \
          hunspell-en_us hunspell-ru libreoffice-extension-languagetool mpv)
#
# Utilities 
PKGLIST+=(mesa-utils vulkan-tools htop nvtop xeyes wireguard-tools neofetch nnn)
#
# Software
PKGLIST+=(filezilla keepassxc firefox telegram-desktop qbittorrent clipgrab \
          authy google-chrome notion-app webcord)
#
# Go
PKGLIST+=(go)
#
# Games
PKGLIST+=(steam mangohud lib32-mangohud)
STOWLIST+=(mangohud)
#
#
#
### Refresh keyring(requires entropy)
# pacman-key --init
# pacman-key --populate archlinux
# pacman-key --refresh-keys
# sudo pacman -Sy
#
### Mirror generation
# sudo pacman -S reflector
# reflector --latest 15 --protocol https --country France --country Germany \
#           --sort rate --save /etc/pacman.d/mirrorlist
# sudo pacman -Syyuu
#
### Install tweaks for arch zen core 
# paru -S cfs-zen-tweaks
# systemctl enable --now set-cfs-tweaks.service
#
#
#
### Install(requires git)
echo ${PKGLIST[@]}
# git clone https://aur.archlinux.org/paru.git $HOME/gits/paru
# cd $HOME/gits/paru && makepkg -si
# cd .. && rm -rf paru
# paru -S ${PKGLIST[@]}
#
### Create link configs
echo ${STOWLIST[@]}
# stow ${STOWLIST[@]}
#
### STOW /etc location
#
# Bluetooth simple settings 
# sudo rm /etc/bluetooth/main.conf
# sudo stow -t /etc/bluetooth bluez

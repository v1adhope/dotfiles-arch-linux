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
PKGLIST+=(ttf-hack-nerd)
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
PKGLIST+=(mesa-utils vulkan-tools bluez-utils htop nvtop inxi xorg-xeyes wireguard-tools neofetch nnn cronie)
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
# sudo pacman -S reflector
# sudo reflector --latest 15 --protocol https --country France --country Germany \
#           --sort rate --save /etc/pacman.d/mirrorlist
# sudo pacman -Syyuu
#
### Install tweaks for arch zen core 
# paru -S cfs-zen-tweaks
# sudo systemctl enable --now set-cfs-tweaks.service
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
#
#
### Set zsh shell
#
# chsh -s /bin/zsh
#
### Bluetooth enable with simple settings 
# rfkill unblock bluetooth
# sudo systemctl enable -now bluetooth.service
# sudo rm /etc/bluetooth/main.conf
# sudo stow -t /etc/bluetooth bluetooth-stack

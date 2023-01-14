#!/bin/bash

### Attention please!!!
#
# Comment/uncomment the groups you want
#
# Use install_paru function if you have not paru
#
# recommend pacstrap pkgs: base base-devel linux-zen linux-zen-headers \
#                          linux-lts linux-lts-headers linux-firmware \
#                          btrfs-progs vim git grub efibootmgr dhcpcd \
#                          dhclient networkmanager
#
# A reboot is required after installation

function TRIM_enable {
  echo -e "\n***** enabling TRIM... *****\n"
  sudo systemctl enable fstrim.timer
  if [ 0 == $? ]; then
    echo "TRIM is on"
  fi
}

function install_paru {
  echo -e "\n*****  installation of the AUR paru manager... *****\n"
  git clone --depth=1 https://aur.archlinux.org/paru-bin.git
  cd paru && makepkg -si
  cd .. && rm -rf paru
  if [ 0 == $? ]; then
    echo "paru installed"
  fi
}

function mirror_generation {
  echo -e "\n***** mirror generation... *****\n"
  paru -S reflector
  sudo reflector --latest 15 --protocol https --country DE,FR,US \
                 --sort rate --save /etc/pacman.d/mirrorlist
  paru -Syu
  if [ 0 == $? ]; then
    echo "mirrors generated"
  fi
}

function refresh_keyring {
  echo -e "\n***** keychain update... *****\n"
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
  sudo pacman-key --refresh-keys
  if [ 0 == $? ]; then
    echo "keychain updated"
  fi
  # mirror gen are recommended
  mirror_generation
}

function zen_core_tweaks {
  echo -e "\n***** installing tweaks to the linux zen kernel... *****\n"
  paru -S cfs-zen-tweaks
  sudo systemctl enable --now set-cfs-tweaks.service
  if [ 0 == $? ]; then
    echo "tweaks installed"
  fi
}

### Functions
# Uncomment below to use
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
          hunspell-en_us hunspell-ru xdg-desktop-portal jq bat viu \
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
echo -e "\n***** Packages list *****\n${PKGLIST[@]}\n"
# paru -S ${PKGLIST[@]}

### Create link configs
#
echo -e "\n***** Configs list *****\n${STOWLIST[@]}\n"
# stow ${STOWLIST[@]}

### Fixes and automation
#
function settings {
  echo -e "\n***** make the necessary adjustments... *****\n"
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
  elif [ $i == "pipewire" ]
    then
      # Use for immediate application pipewire
      systemctl restart --user pipewire.service
      systemctl --user daemon-reload
    fi
done
}
# Uncomment below to use
# settings

### NetworkManager
#
# sudo stow -t /etc/NetworkManager/conf.d/ networkmanager

### Fonts setup
#
# sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
# sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
# sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
#
# Uncomment export FREETYPE_PROPERTIES="truetype:interpreter-version=40" in /etc/profile.d/freetype2.sh
#
# sudo stow -t /etc/fonts fonts
# fc-cache

### Create grub link config
#
# sudo rm /etc/default/grub
# sudo stow -t /etc/default grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg

### Create bluetooth link config
#
# sudo rm /etc/bluetooth/main.conf
# sudo stow -t /etc/bluetooth bluetooth-stack

### Mimetype TODO: system overwrites the file
#
# cat mimetype/.config/mimeapps.list > $HOME/.config/mimeapps.list

### Choosing LSP
#
#SEE: dotfiles/install-lsp/
LSPLIST=()
LSPLIST+=(go lua)
#
#echo -e "\n***** LSP list *****\n${LSPLIST[@]}\n"
#
function install_lsp {
  echo -e "\n***** installing LSP servers... *****\n"
  for i in ${LSPLIST[@]}; do
    "./install-lsp/install-$i-lsp.sh"
  done
}
# install_lsp

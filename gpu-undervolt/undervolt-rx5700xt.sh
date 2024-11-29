#!/bin/bash

current_conf=$(readlink -f /sys/class/drm/card0/device/pp_od_clk_voltage | grep "No such file or directory")

if [ "$current_conf" != "" ]
  then
  echo "Add amdgpu.ppfeaturemask=0xffffffff to GRUB_CMDLINE_LINUX_DEFAULT"
  exit
fi

exit
cfg_path=$HOME/.local/dotfiles-arch-linux/gpu-undervolt

# Undervolt
sudo ln -sf $cfg_path/custom-values/amdgpu-custom-states.card0 /etc/default/amdgpu-custom-states.card0
sudo ln -sf $cfg_path/runner/amdgpu-clocks /usr/local/bin/amdgpu-clocks
sudo ln -sf $cfg_path/service/amdgpu-clocks.service /lib/systemd/system/amdgpu-clocks.service
sudo systemctl enable --now amdgpu-clocks
sudo systemctl status amdgpu-clocks

# Fun control
sudo ln -sf $cfg_path/amdgpu-fan/amdgpu-fan.yml /etc/amdgpu-fan.yml
sudo systemctl enable --now amdgpu-fan

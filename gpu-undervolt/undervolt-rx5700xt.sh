#!/bin/bash

current_conf= sudo cat $(readlink -f /sys/class/drm/card0/device)/pp_od_clk_voltage | grep "No such file or directory"

if [ "$current_conf" != "" ]
  then
  echo "Add amdgpu.ppfeaturemask=0xffffffff in grub init params"
  exit
fi

sudo stow -t /etc/default custom-values
sudo stow -t /usr/local/bin runner
sudo stow -t /lib/systemd/system service
sudo systemctl enable --now amdgpu-clocks
sudo systemctl status amdgpu-clocks

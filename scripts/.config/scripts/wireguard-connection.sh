#!/bin/bash

# DNS changer integrated into wg-quick.conf

config="wg-quick@arch_wg.service"

status=$(systemctl is-active $config)

case $1 in
-c) echo "$status";;
-s)
if [ "$status" == "active" ]
  then
    sudo systemctl stop $config
  else
    sudo systemctl start $config
fi
echo "done!"
;;
*)
  echo "Uncknown:
Use -c for check is-active status wg-quick.service
Use -s for on/off wireguard VPN"
;;
esac


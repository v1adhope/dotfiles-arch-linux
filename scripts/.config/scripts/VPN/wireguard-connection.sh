#!/bin/bash

# DNS changer integrated into wg-quick.conf

config="arch_wg"

status=$(systemctl is-active wg-quick@$config.service)

case $1 in
-c) echo "$status";;
-s)
if [ "$status" == "active" ]
  then
    echo "Shutting down the service..."
    sudo systemctl stop "wg-quick@$config.service"
  else
    echo "Starting the service..."
    sudo systemctl start "wg-quick@$config.service"
fi
echo "done!"
;;
*)
  echo "Uncknown:
Use -c for check is-active status wg-quick.service
Use -s for on/off wireguard VPN"
;;
esac


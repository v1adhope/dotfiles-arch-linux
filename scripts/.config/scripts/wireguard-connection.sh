#!/bin/bash

# DNS changer integrated into wg-quick.conf
# Use env for config variable

status=$(systemctl is-active wg-quick@${WG_CONFIG}.service)

case $1 in
-c) echo "$status";;
-s)
if [ "$status" == "active" ]
  then
    echo "Shutting down the service..."
    sudo systemctl stop "wg-quick@${WG_CONFIG}.service"
  else
    echo "Starting the service..."
    sudo systemctl start "wg-quick@${WG_CONFIG}.service"
fi
;;
*)
  echo "Uncknown:
Use -c for check is-active status wg-quick.service
Use -s for on/off wireguard VPN"
;;
esac

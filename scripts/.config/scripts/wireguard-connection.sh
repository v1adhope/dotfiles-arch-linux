#!/bin/bash

config="wg-quick@arch_wg.service"
default_DNS="192.168.1.1"
wireguard_DNS="10.0.0.1"
SSID_NAME="KakoyZheParol"

function DNS_changer {
  nmcli c modify $SSID_NAME ipv4.dns $DNS
  nmcli c up $SSID_NAME
}

status=$(systemctl is-active $config)

case $1 in
# Check status
-s) echo "$status";;
-f)
  if [ "$status" == "active" ]
     then
       DNS=$wireguard_DNS
       DNS_changer
       echo "DNS fixed: $wireguard_DNS"
     else
       DNS=$default_DNS
       DNS_changer
       echo "DNS fixed: $default_DNS"
  fi
  echo "done!"
;;
-c) 
  if [ "$status" == "active" ]
    then
      sudo systemctl stop $config
      DNS=$default_DNS
      DNS_changer
    else
      DNS=$wireguard_DNS
      DNS_changer
      sudo systemctl start $config
  fi
  echo "done!"
;;
*)
  echo "Uncknown:
Use -s for check is-active status postgresql.service
Use -c for on/off wireguard VPN
USE -f for fix DNS if network not working, this may help"
;;
esac


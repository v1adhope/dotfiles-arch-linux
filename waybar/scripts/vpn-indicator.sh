#!/bin/bash

### Wireguard
#
# Use $WG_CONFIG to define config name

wg=$(systemctl | grep "wg-quick")

if [ "$wg" != "" ]; then
  status=$(ystemctl is-active wg-quick@${WG_CONFIG}.service)

  if [ "$status" == "active" ]; then
    echo "VPN"
  fi

  exit 0
fi

### Adguard VPN
#

guard=$(command -v adguardvpn-cli)

if [ "$guard" != "" ]; then
  status=$(adguardvpn-cli status | grep "VPN is disconnected")

  if [ "$status" == "" ]; then
    echo "VPN"
  fi

  exit 0
fi

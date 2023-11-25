#!/bin/bash

# Use env for config variable

status=$(systemctl is-active wg-quick@${WG_CONFIG}.service)

if [ "$status" == "active" ]
  then
    echo "VPN"
fi

#!/bin/bash

config="arch_wg"

status=$(systemctl is-active wg-quick@$config)

if [ "$status" == "active" ]
  then
    echo "VPN"
fi


#!/bin/bash

case $1 in
-r) echo "Run reboot..."; sudo systemctl reboot;;
-s) echo "Run shutdown..." ;sudo systemctl poweroff;;
*) echo "unknown";;
esac


#!/bin/bash

case $1 in
-r) echo "Run reboot..."; sudo systemctl reboot;;
-s) echo "Run shutdown..." ;sudo systemctl poweroff;;
*)
  echo "Unknown:
Use -r for reboot
User -s for shutdown"
;;
esac

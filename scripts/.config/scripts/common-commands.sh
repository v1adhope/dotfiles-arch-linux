#!/bin/bash

case $1 in
-r) echo "Run reboot..."; shutdown -r now;;
-s) echo "Run shutdown..." ; shutdown now;;
*)
  echo "Unknown:
Use -r for reboot
User -s for shutdown"
;;
esac

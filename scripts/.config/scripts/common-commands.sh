#!/bin/bash

while getopts ":hrs" opt; do
  case $opt in
    h)
      echo -e "Manual\n"
      echo "   Flags"
      echo -e "\t -r   reboot"
      echo -e "\t -s   shutdown"
      echo "   Args"
      echo -e "\t smb   mount/ umont smb"
      echo -e "\t wg   turn on/ off wireguard"
      exit 0
      ;;
    r)
      echo "=> Run reboot..."
      shutdown -r now
      exit 0
      ;;
    s)
      echo "=> Run shutdown..."
      shutdown now
      exit 0
      ;;
    ?)
      echo "=> Unknown option -$OPTARG">&2
      echo -e "\t usage: command [-h] [-r] [-s] [smb]"
      exit 1
    ;;
  esac
done

if [[ -z $1 ]]; then
  echo "=> Done nothing">&2
  exit 1
fi

if [[ "$1" == "smb" ]]; then
  if ! sudo cat /proc/mounts | grep -q smb; then
    echo "=> Mounting smb..."
    sudo mount -t cifs //192.168.1.1/netstorage /smb -o credentials=/etc/samba/credentials/share
    exit 0
  else
    echo "=> Umounting smb..."
    sudo umount /smb
    exit 0
  fi
fi

# DNS changer integrated into wg-quick.conf
# Use env for config variable
status=$(systemctl is-active wg-quick@${WG_CONFIG}.service)

if [[ "$1" == "wg" ]]; then
  if [ "$status" == "active" ]
    then
      echo "=> Opening wireguard tunnel..."
      sudo systemctl stop "wg-quick@${WG_CONFIG}.service"
      exit 0
    else
      echo "=> Closing wireguard tunnel..."
      sudo systemctl start "wg-quick@${WG_CONFIG}.service"
      exit 0
  fi
fi

echo "=> Done nothing">&2
exit 1

#!/bin/bash

function print_help {
  echo -e "Manual\n"
  echo "   Flags"
  echo -e "\t -h   help"
  echo -e "\t -r   reboot"
  echo -e "\t -s   shutdown"
  echo "   Args"
  echo -e "\t smb   mount/ umont smb"
  echo -e "\t wg   turn on/ off wireguard"
  echo -e "\t cam  enable android cam"
}

while getopts ":hrs" opt; do
  case $opt in
    h)
      print_help
      exit 1
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
      print_help
      exit 1
    ;;
  esac
done

if [[ -z $1 ]]; then
  print_help
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
if [[ "$1" == "wg" ]]; then
  status=$(systemctl is-active wg-quick@${WG_CONFIG}.service)
  if [ "$status" == "active" ]
    then
      echo "=> Closing wireguard tunnel..."
      sudo systemctl stop "wg-quick@${WG_CONFIG}.service"
      exit 0
    else
      echo "=> Opening wireguard tunnel..."
      sudo systemctl start "wg-quick@${WG_CONFIG}.service"
      exit 0
  fi
fi

if [[ "$1" == "cam" ]]; then
  sudo modprobe v4l2loopback -r
  sudo modprobe v4l2loopback exclusive_caps=1
  scrcpy --v4l2-sink=/dev/video0 \
         --lock-video-orientation=1 \
         --stay-awake \
         --max-fps=30 \
         --crop=1080:1560:0:300 \
         --turn-screen-off \
         --power-off-on-close \
         --no-display &>/dev/null &
  sleep 3
  ffplay -i /dev/video0
  kill %%
  exit 0
fi

print_help
exit 1
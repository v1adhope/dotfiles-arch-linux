#!/bin/bash

function print_help {
  echo -e "Manual\n"
  echo "   Flags"
  echo -e "\t -h   help"
  echo -e "\t -a   mount/ unmount access folder"
  echo -e "\t -r   reboot"
  echo -e "\t -s   shutdown"
  echo "   Args"
  echo -e "\t smb   mount/ umont smb"
  echo -e "\t wg   turn on/ off wireguard"
  echo -e "\t cam  enable android cam"
  echo -e "\t guard   turn on/ off adguard vpn"
}

### System manipulation
#

while getopts ":hars" opt; do
  case $opt in
    a)
      if [[ "$(ls /mnt/access)" == "" ]]; then
        echo "=> Mount access folder..."
        sudo mount /dev/sd[ab]1 /mnt/access || print_help && exit 1
      else
        echo "=> Unmount access folder..."
        sudo umount /mnt/access || print_help && exit 1
      fi
      exit 0
      ;;
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

###

if [[ -z $1 ]]; then
  print_help
  exit 1
fi

### Connect remote external drive
#

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

### Wireguard
#
# DNS changer integrated into wg-quick.conf
# Use $WG_CONFIG to define config name

if [[ "$1" == "wg" ]]; then
  status=$(systemctl is-active wg-quick@${WG_CONFIG}.service)

  if [ "$status" == "active" ]
    then
      echo "=> Closing wireguard tunnel..."
      sudo systemctl stop "wg-quick@${WG_CONFIG}.service"
    else
      echo "=> Opening wireguard tunnel..."
      sudo systemctl start "wg-quick@${WG_CONFIG}.service"
  fi

  exit 0
fi

### Android screen (camera)
#

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

### Adguard VPN
#

if [[ "$1" == "guard" ]]; then
  status=$(adguardvpn-cli status | grep "VPN is disconnected")

  if [ "$status" != "" ]; then
    adguardvpn-cli connect -l NL
    exit 0
  fi

  adguardvpn-cli disconnect
  exit 0
fi

print_help
exit 1

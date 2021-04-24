#!/bin/bash

if [ "$HOSTNAME.sh" != "${0##*/}" ] && [ "$1" != "-y" ]; then
  <&2 echo "Wrong hostname."
  sleep 1

  read -p "Are you sure you want to continue? [y/n] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    exit
  fi
fi
if [[ $EUID -eq 0 ]]; then
  <&2 echo "You mustn't run this script as root."
  exit
fi

printf "%s\n" "# Updating"
sudo apt update
sudo apt upgrade -y

printf "%s\n" "# Adjusting hostname"
sudo raspi-config nonint do_hostname magic-mirror

#sudo hostname -b magic-mirror
#sudo sed -i "s/ raspberrypi$/ magic-mirror/" /etc/hosts
#sudo sed -i "s/^127.0.1.1.*/127.0.1.1       magic-mirror/" /etc/hosts
# recreating ssh keys for new hostname
#sudo rm /etc/ssh/ssh_host_*
#sudo dpkg-reconfigure openssh-server
#sudo service ssh restart

#? reboot

printf "%s\n" "# Setting resolution"
sudo raspi-config nonint do_resolution 2 82

printf "%s\n" "# Setting timezone"
sudo raspi-config nonint do_change_timezone Europe/Berlin

printf "%s\n" "# Setting wifi country"
sudo raspi-config nonint do_wifi_country DE

printf "%s\n" "# Disable blank screen"
sudo raspi-config nonint do_blanking 1 # -> 1 disables, 0 enables

printf "%s\n" "# Auto-login with console"
sudo raspi-config nonint do_boot_behaviour B2

printf "%s\n" "# Rotating screen"
if ! grep -q "display_rotate=3" /boot/config.txt; then
  echo "" | sudo tee -a /boot/config.txt >/dev/null # adding a new line
  echo "display_rotate=3" | sudo tee -a /boot/config.txt >/dev/null
fi

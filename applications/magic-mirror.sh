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

printf "%s\n" "# Install X, Browser and mouse-hider"
sudo apt install -y xorg chromium-browser unclutter

printf "%s\n" "# Autostart X after login"
if ! grep -q 'startx' ~/.bash_profile; then
  echo 'if [[ ! ${DISPLAY} && ${XDG_VTNR} == 1 ]]; then'| tee ~/.bash_profile >/dev/null
  echo '  startx   # "exec startx" -> remove the exec to remain logged in when your wm ends' | tee -a ~/.bash_profile >/dev/null
  echo 'fi' | tee -a ~/.bash_profile >/dev/null
fi

printf "%s\n" "# Install Docker with convenience script"
bash <(curl -fsSL https://get.docker.com)
sudo usermod -aG docker pi

printf "%s\n" "# Install docker-compose"
sudo apt-get install -y python3 python3-pip
sudo pip3 -v install docker-compose

printf "%s\n" "# Autostart magicmirror and Browser in Kiosk mode"
rm ~/.xinitrc 2&>/dev/null || true # silently delete if file exists
printf "%s\n" \
  "#!/bin/sh" \
  "xset -dpms" \
  "xset s off" \
  "xset s noblank" \
  "" \
  "docker-compose -p magicmirror -f ~/iac/applications/magic-mirror/magic-mirror-compose.yml up -d" \
  "unclutter &" \
  "sleep 10" \ # allow the magic mirror container to start
  "chromium-browser --kiosk --no-first-run --incognito --disable-translate http://localhost:8888" \
  | tee -a ~/.xinitrc

printf "%s\n" "Rebooting in 3 seconds ..."
sleep 3
sudo reboot



#####

# printf "%s\n" "# Configure i3 to prevent prompt at login"
# cp /etc/i3/config ~/.config/i3/config
# sed -i "s/^exec i3-config-wizard$//" ~/.config/i3/config

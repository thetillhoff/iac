#!/bin/bash

# requires:
# - installed ubuntu 20.04 (server mode)
# - installed xorg & gnome

sudo apt install -y \
  openssh-server \
  firefox \
  libdvd-pkg \
  vlc

sudo ufw allow ssh

# TODO:
# - login to firefox account (so tabs can be send)
# - enable firefox sync (bookmarks)
# - set firefox to restore last tabs after restart
# - enable gnome autologin (no password at login)

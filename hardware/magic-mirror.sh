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

printf "%s\n" "Doing nothing."
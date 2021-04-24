#!/bin/bash

if [ "$HOSTNAME.sh" != "${0##*/}" ]; then
  <&2 echo "Wrong hostname."
  exit
fi
if [[ $EUID -eq 0 ]]; then
  <&2 echo "You mustn't run this script as root."
  exit
fi

# create postgres secret
file=postgres/postgres.secret.ignored
if [ ! -f "$file" ]; then
  echo "POSTGRES_USER=root" > "$file"
  echo "POSTGRES_PASSWORD=$(openssl rand -base64 32)" >> "$file"
fi

# create mariadb secret
file=mariadb/mariadb.secret.ignored
if [ ! -f "$file" ]; then
  echo "MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)" > "$file"
fi

# create bitwarden secret
file=bitwarden/bitwarden.secret.ignored
if [ ! -f "$file" ]; then
  echo "ADMIN_TOKEN=$(openssl rand -base64 32)" > "$file"
fi

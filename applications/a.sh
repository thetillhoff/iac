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

# create vaultwarden secret
file=vaultwarden/vaultwarden.secret.ignored
if [ ! -f "$file" ]; then
  echo "ADMIN_TOKEN=$(openssl rand -base64 32)" > "$file"
fi

# create bookstack secret
file=bookstack/bookstack.secret.ignored
DB_ROOT_PASS=$(openssl rand -base64 32)
DB_BOOKSTACK_USER=bookstack
DB_BOOKSTACK_PASS=$(openssl rand -base64 32)
if [ ! -f "$file" ]; then
  echo "DB_USER=$DB_BOOKSTACK_USER" > "$file"
  echo "DB_PASS=$DB_BOOKSTACK_PASS" >> "$file"
fi
# create bookstack-db secret
file=bookstack/bookstack-db.secret.ignored
if [ ! -f "$file" ]; then
  echo "MYSQL_ROOT_PASSWORD=$DB_ROOT_PASS" > "$file"
  echo "MYSQL_USER=$DB_BOOKSTACK_USER" >> "$file"
  echo "MYSQL_PASSWORD=$DB_BOOKSTACK_PASS" >> "$file"
fi

# create plausible secret
file=plausible/plausible-conf.env
if [ ! -f "$file" ]; then
echo "ADMIN_USER_EMAIL=info@enforge.de" > "$file"
echo "ADMIN_USER_NAME=enforge" >> "$file"
echo "ADMIN_USER_PWD=$(openssl rand -base64 64)" >> "$file"
echo "BASE_URL=https://analytics.enforge.de" >> "$file"
echo "SECRET_KEY_BASE=$(openssl rand -base64 64)" >> "$file"
echo "PORT=80" >> "$file"
fi

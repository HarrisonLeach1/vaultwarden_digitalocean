#!/bin/bash
NOCOLOR=$( tput sgr 0 )
GREEN=$( tput setaf 2 )
CYAN=$( tput setaf 6 )

echo -e "\n${CYAN}########## init script - setting config variables ##########${NOCOLOR}\n"
cd /srv/vw

# set timezone
. .env
timedatectl set-timezone $TZ

# set fail2ban email
sed -i "s/destemail =.*/destemail = ${FAIL2BAN_DESTEMAIL}/g" ./fail2ban/jail.d/jail.local
sed -i "s/sender =.*/sender = ${FAIL2BAN_SENDER}/g" ./fail2ban/jail.d/jail.local

echo -e "\n${CYAN}########## init script - starting docker containers ##########${NOCOLOR}\n"
docker compose up -d

echo -e "\n${GREEN}init script completed${NOCOLOR}\n" 
#!/bin/bash
LOG_FILE=/var/log/user_data.log

NOCOLOR=$( tput sgr 0 )
GREEN=$( tput setaf 2 )
CYAN=$( tput setaf 6 )

# WORKAROUND: Digital ocean has a droplet docker image (docker-20-04, see: https://marketplace.digitalocean.com/apps/docker) 
# but it currently doesn't support a droplet with a 10gb disk size. So we need to install docker ourselves.
echo -e "\n${CYAN}########## Installing docker ##########${NOCOLOR}\n" | tee $LOG_FILE
apt-get update | tee -a $LOG_FILE
apt -y install apt-transport-https ca-certificates curl software-properties-common | tee -a $LOG_FILE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null 
apt update | tee -a $LOG_FILE
apt-cache policy docker-ce | tee -a $LOG_FILE
apt -y install docker-ce | tee -a $LOG_FILE

echo -e "\n${CYAN}########## Installing docker compose ##########${NOCOLOR}\n" | tee -a $LOG_FILE 
mkdir -p ~/.docker/cli-plugins/ | tee -a $LOG_FILE
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose | tee -a $LOG_FILE
chmod +x ~/.docker/cli-plugins/docker-compose | tee -a $LOG_FILE

echo -e "\n${CYAN}########## Configuring auto reboot on updates ##########${NOCOLOR}\n" | tee -a $LOG_FILE 
# Enable automatic reboots and if a reboot is needed schedule it for 3am (in timezone specified in TZ vw/.env variable)
echo -e "Unattended-Upgrade::Automatic-Reboot \"true\";\n
Unattended-Upgrade::Automatic-Reboot-Time \"03:00\";\n" | tee /etc/apt/apt.conf.d/55unattended-upgrades-local

# Make dir for vaultwarden
mkdir /srv/vw 2> /dev/null

echo -e "\n${GREEN}Initial server setup complete${NOCOLOR}\n" | tee -a $LOG_FILE 

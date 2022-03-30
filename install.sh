#!/bin/bash

# kill any background updater jobs
sudo killall apt apt-get

sudo apt-get update -y
#sudo apt-get upgrade -y

# docker
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt-get install -y docker-ce

# entropy fix for docker
sudo apt-get install -y haveged

# docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# liveswitch docker compose
sudo cp /opt/liveswitch/docker-compose-liveswitch.service /etc/systemd/system/
sudo systemctl enable docker
sudo systemctl enable docker-compose-liveswitch

sudo systemctl start docker-compose-liveswitch
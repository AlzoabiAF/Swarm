#!/bin/bash

apt-get update
apt-get install -y docker.io docker-compose-v2 ssh firewalld
systemctl start docker
systemctl enable docker

bash /vagrant/open_ports.sh

sudo docker swarm init --advertise-addr 192.168.56.10 | grep "docker swarm join --token" > /vagrant/worker_token.sh
if [ $? -ne 0 ]; then
    echo -e "\033[31mDocker swarm initialization failed!\033[0m"
fi
chmod +x /vagrant/worker_token.sh


docker network create --driver overlay --attachable overlay

docker compose --file /vagrant/docker-compose.yml up -d
docker stack deploy -c /vagrant/docker-compose.yml stage

docker compose --file /vagrant/docker-portainer.yml up -d
docker stack deploy -c /vagrant/docker-portainer.yml portainer

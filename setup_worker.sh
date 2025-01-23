#!/bin/bash

apt update
apt install -y docker.io docker-compose-v2 ssh firewalld

systemctl start docker
systemctl enable docker

bash /vagrant/open_ports.sh

/vagrant/worker_token.sh
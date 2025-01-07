#!/bin/bash

firewall-cmd --zone=public --add-port=2376/tcp --permanent
firewall-cmd --zone=public --add-port=2377/tcp --permanent
firewall-cmd --zone=public --add-port=7946/tcp --permanent
firewall-cmd --zone=public --add-port=7946/udp --permanent
firewall-cmd --zone=public --add-port=4789/udp --permanent
firewall-cmd --reload

iptables -N swarm
iptables -A INPUT -p tcp --dport 2376 -j swarm
iptables -A INPUT -p tcp --dport 2377 -j swarm
iptables -A INPUT -p udp --dport 4789 -j swarm
iptables -A INPUT -p udp --dport 7946 -j swarm
iptables -A INPUT -p tcp --dport 7946 -j swarm
iptables -A swarm -s 192.168.56.10 -j ACCEPT
iptables -A swarm -s 192.168.56.11 -j ACCEPT
iptables -A swarm -s 192.168.56.12 -j ACCEPT
iptables -A swarm -j DROP


systemctl restart docker;
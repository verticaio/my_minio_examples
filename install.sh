#!/bin/bash

## Update , install common packages for Kafka Cluster
echo -e "\e[1;31m configure Hosts file for your enviroment  \e[0m"
sudo echo -e "172.20.20.21  minio01 
172.20.20.22   minio02 
172.20.20.23   minio03
172.20.20.24   minio04" |  sudo tee --append /etc/hosts

echo -e "\e[1;31m Change sshd config for vagrant box and restart service  \e[0m"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/UseDNS no/UseDNS yes/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo -e "\e[1;31m Change root pass  \e[0m"
sudo echo "root" | sudo passwd --stdin root

#echo -e "\e[1;31m Update and install packages  \e[0m"
sudo yum update -y &&  sudo yum install vim nc wget ca-certificates zip net-tools nano tar jq -y

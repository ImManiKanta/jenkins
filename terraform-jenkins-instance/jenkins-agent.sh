#!/bin/bash
sudo growpart /dev/nvme0n1 4

sudo lvextend -L +10G /dev/RootVG/rootVol
sudo lvextend -L +10G /dev/RootVG/varVol
sudo lvextend -L +10G /dev/mapper/RootVG-homeVol 

sudo xfs_growfs /
sudo xfs_growfs /var
sudo xfs_growfs /home

#java install
sudo yum install fontconfig java-21-openjdk -y

npm install

# Docker
dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
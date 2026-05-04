#!/bin/bash

sudo growpart /dev/nvme0n1 4

sudo lvextend -L +10G /dev/RootVG/rootVol
sudo lvextend -L +10G /dev/RootVG/varVol
sudo lvextend -L +10G /dev/mapper/RootVG-homeVol

sudo xfs_growfs /
sudo xfs_growfs /var
sudo xfs_growfs /home

#jenkins install
sudo curl -o /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/rpm-stable/jenkins.repo 

sudo yum install fontconfig java-21-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
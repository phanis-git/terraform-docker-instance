#!/bin/bash

growpart /dev/nvme0n1 4
# Resize PV so VG gets free space
pvresize /dev/nvme0n1p4
lvextend -L +30G /dev/mapper/RootVG-varVol 
xfs_growfs /var
sleep 50 &
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker ec2-user


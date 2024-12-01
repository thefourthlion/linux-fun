\#!/bin/bash

# List of packages to install
apt_packages=(
    python3
    wireshark
    audacity
    vlc
    putty
    snapd
    curl
    git
    gh
    build-essential
    wine64
    gimp
    obs-studio
    inkscape
    timeshift
    net-tools
    ca-certificates 
    docker-ce 
    docker-ce-cli 
    containerd.io 
    docker-buildx-plugin 
    docker-compose-plugin
    ffmpeg
    software-properties-common
    apt-transport-https
    brave-browser
)

snap_packages=(  
  winbox
  discord
  figma-linux
  trello-desktop
)

sudo apt update
sudo apt upgrade -y

# ----- Add repositories to apt
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:inkscape.dev/stable -y


# Install each apt package in the array
for package in "${apt_packages[@]}"
do
    sudo apt install -y "$package"
done

# Install each snap package in the array
for package in "${snap_packages[@]}"
do
    sudo snap install "$package"
done

echo "Applications done installing. Recommend doing a reboot."

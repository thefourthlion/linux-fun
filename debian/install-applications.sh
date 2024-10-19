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

# ----- Install PIA VPN
wget https://installers.privateinternetaccess.com/download/pia-linux-3.6.1-08339.run
sudo sh ./pia-linux-3.6.1-08339.run 

# ----- Balena Etcher install
if ! wget https://balena.io/etcher/assets/releases/1.19.25/balena-etcher-electron_1.19.25_amd64.deb; then
    echo "Failed to download Balena Etcher. Exiting."
    exit 1
fi
sudo dpkg -i balena-etcher-electron_1.19.25_amd64.deb

# ----- Docker Installation
# Remove any older versions of Docker
sudo apt remove -y docker docker-engine docker.io containerd runc
# Set up the Docker GPG key
if [ ! -d /etc/apt/keyrings ]; then
    sudo mkdir -m 0755 -p /etc/apt/keyrings
fi
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
# Add the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Update the package index
sudo apt update
# Install Docker Engine, CLI, and containerd
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Optionally add the current user to the Docker group to run Docker without sudo
sudo usermod -aG docker "$USER"
echo "Docker installed successfully. Please log out and back in for group changes to take effect."

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
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
    gh
    wine64
    brave-browsers
    obs-studio
    inkscape
    net-tools
    # local deb files
    ./steam.deb 
    ./codium_1.90.2.24171_amd64.deb
    # docker
    ca-certificates 
    docker-ce 
    docker-ce-cli 
    containerd.io 
    docker-buildx-plugin 
    docker-compose-plugin
)

snap_packages=(  
  winbox
  discord
)

sudo apt update

# ----- PIA VPN install 
wget https://installers.privateinternetaccess.com/download/pia-linux-3.5.7-08120.run

sudo sh ./pia-linux-3.5.7-08120.run 

# ----- Steam install
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb

# ----- VSCodium install
wget https://code.visualstudio.com/docs/?dv=linux64_deb

# ----- Brave install
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# ----- OBS install
sudo add-apt-repository ppa:obsproject/obs-studio

# ----- Inkscape install
sudo add-apt-repository universe
sudo add-apt-repository ppa:inkscape.dev/stable

# ----- Docker Install
# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install each apt package in the array
for package in "${apt_packages[@]}"
do
    sudo apt install -y "$package"
done

# Install each snap package in the array
for package in "${apt_packages[@]}"
do
    sudo snap install -y "$package"
done

echo "Applications done installing. Recomend doing a reboot.

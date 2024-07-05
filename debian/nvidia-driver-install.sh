\#!/bin/bash

# get rid of any traces of nvidia drive info
sudo apt autoremove nvidia* --purge

# enable non free software
sudo apt install software-properties-common -y

# update your packages
sudo apt update

# install 64b headers
sudo apt install linux-headers-amd64

# install nvidia detect
sudo apt install nvidia-detect

# install nvidia drivers
sudo apt install nvidia-driver linux-image-amd64

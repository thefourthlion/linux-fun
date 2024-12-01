#!/bin/bash

VFIO_CONF="/etc/modprobe.d/vfio.conf"
VFIO_CONTENT="options vfio-pci ids=10de:2860,10de:22bd
softdep nvidia pre: vfio-pci"

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Function to check if GPU is passed through
function is_gpu_passed_through() {
    grep -q "^options vfio-pci" "$VFIO_CONF" 2>/dev/null
    return $?
}

# Check if config file exists, create if it doesn't
if [ ! -f "$VFIO_CONF" ]; then
    touch "$VFIO_CONF"
fi

if is_gpu_passed_through; then
    echo "Disabling GPU passthrough..."
    sed -i 's/^options/#options/' "$VFIO_CONF"
    sed -i 's/^softdep/#softdep/' "$VFIO_CONF"
else
    echo "Enabling GPU passthrough..."
    sed -i '/vfio-pci/d' "$VFIO_CONF"
    echo "$VFIO_CONTENT" > "$VFIO_CONF"
fi

# Update initramfs
echo "Updating initramfs..."
update-initramfs -u

echo "Configuration updated. System needs to reboot."
read -p "Would you like to reboot now? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    reboot
fi

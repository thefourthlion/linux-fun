#!/bin/bash

# Function to create a Timeshift backup
create_backup() {
    # Prompt user for backup name
    read -p "Enter a name for the backup: " backup_name
    
    # Get the current date in YYYY-MM-DD format
    current_date=$(date +%Y-%m-%d)
    
    # Define the backup file name
    backup_file="$HOME/Desktop/${backup_name} - ${current_date}.rsync"
    
    # Create the backup using Timeshift
    sudo timeshift --create --comments "$backup_name - $current_date" --snapshot-device /dev/sda1 --backup-type rsync --save-path "$backup_file"
    
    echo "Backup created successfully: $backup_file"
}

# Check if Timeshift is installed
if ! command -v timeshift &> /dev/null; then
    echo "Timeshift is not installed. Please install it first."
    exit 1
fi

# Execute the backup function
create_backup

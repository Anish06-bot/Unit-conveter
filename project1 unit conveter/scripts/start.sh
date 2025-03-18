#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Starting deployment..."

# Update package list
sudo apt update -y

# Install Apache (Only if not already installed)
if ! command -v apache2 &> /dev/null; then
    sudo apt install -y apache2
fi

# Ensure Apache is running
sudo systemctl restart apache2
sudo systemctl enable apache2

# Ensure the web root directory exists
if [ ! -d "/var/www/html" ]; then
    sudo mkdir -p /var/www/html
fi

# Clear existing website files
sudo rm -rf /var/www/html/*

# Ensure source directory exists before copying files
if [ -d "/home/ubuntu/deploy-temp" ]; then
    sudo cp /home/ubuntu/deploy-temp/* /var/www/html/
else
    echo "Error: Source directory /home/ubuntu/deploy-temp/ does not exist!"
    exit 1
fi

# Set correct ownership and permissions
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

echo "Deployment completed successfully!

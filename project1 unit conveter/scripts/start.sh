#!/bin/bash

# Exit if any command fails
set -e

echo "Starting deployment process..."

# Install Apache HTTP Server if not already installed
sudo yum install -y httpd

# Ensure Apache is running
sudo systemctl start httpd
sudo systemctl enable httpd

# Clear existing files in the web root
sudo rm -rf /var/www/html/*

# Copy the new index.html and other assets to the web root
sudo cp -r * /var/www/html/

# Set proper permissions
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/w

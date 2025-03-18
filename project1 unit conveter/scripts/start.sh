#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Starting deployment..."

# Update package list
sudo apt update -y

# Install Apache if not already installed
if ! command -v apache2 &> /dev/null; then
    sudo apt install -y apache2
fi

# Ensure Apache is running
sudo systemctl restart apache2
sudo systemctl enable apache2

# Define the deployment source and destination
SOURCE_DIR="/home/ubuntu/deploy-temp"
DEST_DIR="/var/www/html"

# Ensure the web root directory exists
if [ ! -d "$DEST_DIR" ]; then
    sudo mkdir -p "$DEST_DIR"
fi

# Clear existing website files
sudo rm -rf "$DEST_DIR"/*

# Ensure source directory exists before copying files
if [ -d "$SOURCE_DIR" ]; then
    sudo cp -r "$SOURCE_DIR/index.html" "$DEST_DIR/"
    sudo cp -r "$SOURCE_DIR/style.css" "$DEST_DIR/"
    sudo cp -r "$SOURCE_DIR/myscript.js" "$DEST_DIR/"
else
    echo "Error: Source directory $SOURCE_DIR does not exist!"
    exit 1
fi

# Set correct ownership and permissions
sudo chown -R www-data:www-data "$DEST_DIR"
sudo chmod -R 755 "$DEST_DIR"

# Restart Apache to apply changes
sudo systemctl restart apache2

echo "Deployment completed successfully!"

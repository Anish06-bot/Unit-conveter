#!/bin/bash

set -e  # Exit if any command fails

echo "Starting deployment via AWS CodeDeploy..."

# Define deployment directory
DEST_DIR="/var/www/html"

# Ensure the web root directory exists
if [ ! -d "$DEST_DIR" ]; then
    sudo mkdir -p "$DEST_DIR"
fi

# Remove old files before deploying new ones
echo "Removing old files..."
sudo rm -rf $DEST_DIR/*

# Copy new files from the deployment directory to Apache's web root
echo "Copying new files..."
sudo cp -r * "$DEST_DIR"

# Set correct ownership and permissions
echo "Setting correct permissions..."
sudo chown -R www-data:www-data "$DEST_DIR"
sudo chmod -R 755 "$DEST_DIR"

# Restart Apache to apply changes
echo "Restarting Apache server..."
sudo systemctl restart apache2

echo "Deployment completed successfully!"

#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Starting deployment via AWS CodeDeploy..."

# Define destination directory (where your files are deployed)
DEST_DIR="/var/www/html"

# Ensure the web root directory exists
if [ ! -d "$DEST_DIR" ]; then
    sudo mkdir -p "$DEST_DIR"
fi

# Set correct ownership and permissions
echo "Setting correct permissions..."
sudo chown -R www-data:www-data "$DEST_DIR"
sudo chmod -R 755 "$DEST_DIR"

# Restart Apache to apply changes
echo "Restarting Apache server..."
sudo systemctl restart apache2

echo "Deployment completed successfully!"

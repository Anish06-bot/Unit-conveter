#!/bin/bash
 
set -e
 
echo "Starting deployment..."
 
# Install Apache (optional if already installed)
sudo yum install -y httpd
 
# Make sure Apache is running
sudo systemctl start httpd
sudo systemctl enable httpd
 
# Clear existing website
sudo rm -rf /var/www/html/*
 
# Copy new files from CodeDeploy temp directory
sudo cp /home/ec2-user/deploy-temp/index.html /var/www/html/
sudo cp /home/ec2-user/deploy-temp/style.css /var/www/html/
sudo cp /home/ec2-user/deploy-temp/myscript.js /var/www/html/
 
# Set proper permissions
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/
 
echo "Deployment completed!"

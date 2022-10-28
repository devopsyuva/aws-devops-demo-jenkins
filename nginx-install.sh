#!/bin/bash
sudo apt update && apt -y dist-upgrade
sudo apt install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1>Nginx was deployed successful using Jenkins CICD $(hostname -f)</h1>" > /usr/share/nginx/html/index.html
echo "<h1>Nginx was deployed successful using Jenkins CICD $(hostname -f)</h1>" > /var/www/html/index.html

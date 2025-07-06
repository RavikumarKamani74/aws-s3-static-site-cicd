#!/bin/bash

cd /home/ec2-user/myapp

echo "Installing dependencies..."
npm ci

echo "Restarting app with PM2..."
pm2 stop myapp || true
pm2 start npm --name myapp -- start

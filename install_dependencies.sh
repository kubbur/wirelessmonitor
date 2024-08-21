#!/bin/bash

# Update the package list and install necessary dependencies
sudo apt-get update
sudo apt-get install -y vlc ffmpeg python3 python3-pip

# Install Flask for Python
pip3 install Flask

# Create a RAM disk
sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=100M tmpfs /mnt/ramdisk

# Create directories for logs and stream in RAM disk
mkdir -p /mnt/ramdisk/logs
mkdir -p /mnt/ramdisk/stream

echo "Dependencies installed, and RAM disk setup is complete."

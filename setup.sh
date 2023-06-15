#!/bin/bash

# Version 1.0

# Define variables
MINECRAFT_SERVER_DIR="/home/ubuntu/minecraft"
SERVER_JAR_URL="https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar"
HOST_USER="minecraft"


# Update package list
# im so sorry you have to see this, but it's the only thing that worked to install java
sudo apt update
sudo apt update
sudo apt update

# Install OpenJDK
sudo apt -y install openjdk-17-jdk-headless

# Move service file to systemd
mv /home/ubuntu/minecraft.service /etc/systemd/system/minecraft.service

# Create the Minecraft server directory
mkdir -p "$MINECRAFT_SERVER_DIR"

# Set permissions on folder
chown -R ubuntu:ubuntu "${MINECRAFT_SERVER_DIR}"

# Navigate into Minecraft directory
cd "$MINECRAFT_SERVER_DIR"

# Configure Minecraft server properties
echo "motd=CS312 Final Project - Braylon Steffen" > "server.properties"

# Accept Minecraft EULA
echo "eula=true" > "eula.txt" 

# Download the Minecraft server JAR file
wget -O "$MINECRAFT_SERVER_DIR/minecraft_server.jar" "${SERVER_JAR_URL}" 

# Setup systemd for reboot and start server 
systemctl enable minecraft 
systemctl start minecraft

# Success
echo "Setup Done!"

#!/bin/bash

# Version 1.0

# Define variables
MINECRAFT_SERVER_DIR="/home/ubuntu/minecraft"
SERVER_JAR_URL="https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar"
HOST_USER="minecraft"

# Update package list
sudo apt -y update

# Install OpenJDK
sudo apt -y install openjdk-17-jre-headless

# Create the Minecraft server directory
mkdir -p "$MINECRAFT_SERVER_DIR"

# Navigate into Minecraft directory
cd "$MINECRAFT_SERVER_DIR"

# Configure Minecraft server properties
echo "motd=CS312 Final Project - Braylon Steffen" > "server.properties"

# Accept Minecraft EULA
echo "eula=true" > "eula.txt"

# Download the Minecraft server JAR file
wget -O "$MINECRAFT_SERVER_DIR/minecraft_server.jar" "${SERVER_JAR_URL}"

# Start the Minecraft server
nohup java -Xmx1024M -Xms1024M -jar "minecraft_server.jar" nogui 2>&1 &

# Success
echo "Setup Done!"

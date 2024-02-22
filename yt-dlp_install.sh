#!/usr/bin/env bash

# Clear the screen and print a newline
clear
echo $'\n'

# Define the working directory and output folders
WORKING_DIR="$HOME"
YTDL_OUTPUT_FOLDER="$WORKING_DIR/storage/shared/yt-dl"
YTDL_AUDIO_OUTPUT_FOLDER="$WORKING_DIR/storage/shared/yt-dl/audio"
YTDL_CONFIG_FOLDER="$WORKING_DIR/.config/yt-dlp/"
TERMUX_URLOPENER_CONFIG_FOLDER="$WORKING_DIR/bin/"

# Ensure storage access for Termux
echo "Enabling storage access for Termux..."
termux-setup-storage

# Update package lists and upgrade existing packages
echo "Updating and upgrading packages..."
pkg update && pkg upgrade

# Install required packages
echo "Installing Python, ffmpeg, and yt-dlp..."
pkg install python ffmpeg
pip install -U yt-dlp

# To update, run:	pip install -U yt-dlp
echo -e "Installation Finished..."

echo -e "Starting configuration..."
# Create the output, config and url share config directories if they do not exist
mkdir -p "$YTDL_OUTPUT_FOLDER"
mkdir -p "$YTDL_AUDIO_OUTPUT_FOLDER"
mkdir -p "$YTDL_CONFIG_FOLDER"
mkdir -p "$TERMUX_URLOPENER_CONFIG_FOLDER"

# Download the setup and config files from GitHub
curl -L https://raw.githubusercontent.com/khirendra03/yt-dlp_termux/main/yt-dlp.config > "$YTDL_CONFIG_FOLDER/config"
curl -L https://raw.githubusercontent.com/khirendra03/yt-dlp_termux/main/share_ytdl.sh > "$TERMUX_URLOPENER_CONFIG_FOLDER/termux-url-opener"

echo -e "Configuration finished."

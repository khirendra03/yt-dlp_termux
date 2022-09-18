#!/usr/bin/env bash

clear
echo $'\n'

# all folders that we need/use
WORKING_DIR=$(echo "$HOME")
YTDL_OUTPUT_FOLDER="${WORKING_DIR}/storage/shared/yt-dl"
YTDL_AUDIO_OUTPUT_FOLDER="${WORKING_DIR}/storage/shared/yt-dl/audio"
YTDL_CONFIG_FOLDER="${WORKING_DIR}/.config/yt-dlp/"
TERMUX_URLOPENER_CONFIG_FOLDER="${WORKING_DIR}/bin/"

# Installing
termux-setup-storage       # Allow termux to download files into your phone's storage
pkg update && pkg upgrade  # Update all packages
echo 'Updating and installing python, ffmpeg and youtub-dlp'
pkg install python         # Install python
pip install -U yt-dlp      # Install yt-dlp
pkg install ffmpeg         # OPTIONAL: Install ffmpeg

# To update, run:	pip install -U yt-dlp
echo -e "Installation Finished..."

echo -e "Starting configuration..."
# Making Output, config and url share config directory
mkdir -p $YTDL_OUTPUT_FOLDER
mkdir -p $YTDL_AUDIO_OUTPUT_FOLDER
mkdir -p $YTDL_CONFIG_FOLDER
mkdir -p $TERMUX_URLOPENER_CONFIG_FOLDER

# Download setup & config file
curl -L https://raw.githubusercontent.com/khirendra03/yt-dlp_termux/main/yt-dlp.config > "${YTDL_CONFIG_FOLDER}/config"
curl -L https://raw.githubusercontent.com/khirendra03/yt-dlp_termux/main/share_ytdl.sh > "${TERMUX_URLOPENER_CONFIG_FOLDER}/termux-url-opener"


echo -e "configuration finished."


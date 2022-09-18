#!/usr/bin/env bash

# uninstalling program packages 
echo "uninstalling program packages"
pip uninstall yt-dlp
pkg uninstall ffmpeg 

# working directories
WORKING_DIR=$(echo "$HOME")
YTDL_CONFIG_FOLDER="${WORKING_DIR}/.config/yt-dlp/"
TERMUX_URLOPENER_CONFIG_FOLDER="${WORKING_DIR}/bin/"

# deleting config directories
echo "removing configuration"
mkdir -p $YTDL_CONFIG_FOLDER
mkdir -p $TERMUX_URLOPENER_CONFIG_FOLDER

echo "configuration removed"
echo " Uninstall completed"
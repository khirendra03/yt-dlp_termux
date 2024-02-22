#!/bin/bash

clear

if ! command -v yt-dlp &> /dev/null; then
  echo "Error: yt-dlp is not installed. Please install it before running this script."
  exit 1
fi

# Clear and concise prompts
echo "Download (a)udio or (v)ideo?"
read -r answer

case "$answer" in
  a)
    # Validate audio quality input
    read -rp "Choose audio quality (0-10, best=0, worst=10): " quality
    if [[ ! "$quality" =~ ^[0-9]$ ]]; then
      echo "Invalid audio quality. Please enter a number between 0 and 10."
      exit 1
    fi

    # Download audio with specified quality and thumbnail
    yt-dlp -x --audio-format mp3 --audio-quality "$quality" --embed-thumbnail \
      -P "/data/data/com.termux/files/home/storage/shared/yt-dl/" \
      -o "%(title)s.%(ext)s" "$@"
    ;;
  v)
    # Handle YouTube URLs and non-URL inputs gracefully
    if [[ "$1" =~ ^.*(youtu|youtube).* ]]; then
      # Prompt for video and audio quality selections with defaults
      yt-dlp -F "$1"
      read -rp "Choose video quality (press Enter for best): " video
      read -rp "Choose audio quality (press Enter for best): " audio
      video="${video:-bv*}"
      audio="${audio:-ba/b}"

      echo "Downloading video..."
      echo "> URL: $1"
      yt-dlp -f "$video+$audio" "$1"
    else
      echo "Error: Please provide a valid YouTube URL or choose 'a' for audio download."
      exit 1
    fi
    ;;
  *)
    echo "Invalid choice. Please enter 'a' or 'v'."
    exit 1
esac

echo "Download complete!"

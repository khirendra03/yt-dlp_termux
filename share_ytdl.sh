
# Enable strict mode
set -euo pipefail

# Clear the screen and print a newline
clear
printf '\n'

# Check if yt-dlp is installed
if [[ -z $(command -v yt-dlp) ]]; then
  printf "Error: yt-dlp is not installed. Please install it before running this script.\n"
  exit 1
fi

# Create a menu for the user to choose audio or video download
printf "Download (a)udio or (v)ideo?\n"
select choice in "Audio" "Video"; do
  case "$choice" in
    Audio)
      # Validate audio quality input
      printf "Choose audio quality (0-10, best=0, worst=10): "
      read -r quality
      if [[ ! "$quality" =~ ^[0-9]$ ]]; then
        printf "Invalid audio quality. Please enter a number between 0 and 10.\n"
        exit 1
      fi

      # Download audio with specified quality and thumbnail
      yt-dlp -x --audio-format mp3 --audio-quality "$quality" --embed-thumbnail \
        -P "/data/data/com.termux/files/home/storage/shared/yt-dl/" \
        -o "%(title)s.%(ext)s" "$@"
      break
      ;;
    Video)
      # Handle different types of URLs
      case "$1" in
        *youtu*|*youtube*)
          # Prompt for video and audio quality selections with defaults
          yt-dlp -F "$1"
          printf "Choose video quality (press Enter for best): "
          read -r video
          printf "Choose audio quality (press Enter for best): "
          read -r audio
          video="${video:-bv*}"
          audio="${audio:-ba/b}"

          printf "Downloading video...\n"
          printf "> URL: %s\n" "$1"
          yt-dlp -f "$video+$audio" "$1"
          ;;
        *)
          printf "Error: Please provide a valid YouTube URL or choose 'a' for audio download.\n"
          exit 1
          ;;
      esac
      break
      ;;
    *)
      printf "Invalid choice. Please enter 'a' or 'v'.\n"
      exit 1
      ;;
  esac
done

printf "Download complete!\n"

#!/bin/bash
clear

echo "(a)udio, (v)ideo?"
read answer
if [ "$answer" == "a" ]; then
	read -p "choose aduio quality 0-10 (0=best & 10=wrost) : " aquality
    yt-dlp -x --audio-format mp3 --audio-quality "$aquality" --embed-thumbnail -P "/data/data/com.termux/files/home/storage/shared/yt-dl/" -o "%(title)s.%(ext)s" "$1"
elif [ "$answer" == "v" ]; then
	if [[ "$1" =~ ^.*youtu.*$ ]] || [[ "$1" =~ ^.*youtube.*$ ]]; then
	    yt-dlp -F "$1"
  	  read -p "Choose your video quality (press enter for: 'best') : " video
 	   read -p "Choose your audio quality (press enter for: 'best') : " audio
	    if [[ "$video" = "" ]]; then
   	     video="bv*"
 	   fi
	    if [[ "$audio" = "" ]]; then
 	       audio="ba/b"
	    fi
	    echo -e "Downloading video...\\n>URL: ${1}\\n"
	    yt-dlp -f "$video"+"$audio" "$1"
 	   elif [[ "$1" =~ ^.*nourlselected.*$ ]]; then
 	   echo "error"
	else yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" "$1"
	fi
fi
	read -p "completed !!! Press enter to exit"

#!/bin/bash

# Usage: ./play_mp3.sh /path/to/file.mp3

if [ $# -ne 1 ]; then
    echo "Usage: $0 <mp3_file>"
    exit 1
fi

MP3_FILE="$1"

if [ ! -f "$MP3_FILE" ]; then
    echo "Error: File not found: $MP3_FILE"
    exit 1
fi

afplay "$MP3_FILE"

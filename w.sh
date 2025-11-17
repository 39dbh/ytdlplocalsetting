#!/bin/bash

URL_FILE="u.txt"

OUTPUT_DIR="./downloads"

mkdir -p "$OUTPUT_DIR"

yt-dlp \
  -f "bestvideo+bestaudio/best" \
  --merge-output-format mp4 \
  --write-subs \
  --sub-lang ja \
  --embed-subs \
  --live-from-start \
  -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
  -a "$URL_FILE"

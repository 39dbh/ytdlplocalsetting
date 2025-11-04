#!/bin/sh

yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 --embed-thumbnail --embed-chapters --embed-metadata -o "/yt/%(title)s.%(ext)s" -a u.txt

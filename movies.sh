#!/bin/bash
#Prints a list of video files under current path, sorted by length (HH:MM), also counts the files in the end
#Edit the -prune argument for folders to be omitted

EXTENSIONS='.*\(mp4\|mkv\|avi\|webm\|flv\|vob\|mpeg\|mpg\|m4v\)$'

find . -path './~talteen' -prune -o -regex $EXTENSIONS -print0 | while read -d $'\0' line; do
	dur=$(ffprobe -i "$line" -show_entries format=duration -v quiet -of csv="p=0" -pretty)
	printf ${dur::4}
	printf " $line\n"
done | sort
printf "Count: "
find . -path './~talteen' -prune -o -regex $EXTENSIONS | wc -l

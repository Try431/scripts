#!/bin/bash

for dir in /home/isaac/Pictures/idgarza/big-pine/*; do
	echo "$dir"
	found=false
	large=false
	for file in "$dir"/*.jpg; do
		echo $file
		if [[ "$file" == *"2560"* ]]; then
			found=true
		fi
		if [[ "$file" == *"3840"* ]]; then
			large=true
		fi 
	done
	echo $found
	echo $large
	if [ "$found" = false ] && [ "$large" = true ]; then
		inp="$dir"/3840.jpg
		# ffmpeg -y -i "$inp" -vf scale="2560:-1" 2560.jpg
		convert -size 2560x2560 "$inp" -resize 2560x2560 -quality -92 +profile '*' 2560.jpg
		mv -f 2560.jpg "$dir"/2560.jpg
	fi
done
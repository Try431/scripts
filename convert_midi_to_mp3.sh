#!/bin/bash

source_dir=$1
echo $source_dir
dest_dir=$2
for file in "$source_dir"/*.mid; do
	FILENAME=$(echo $file | cut -d . -f 1)
	MIDI_FILE=$FILENAME.mid
	MP3_FILE=$FILENAME.mp3
	fluidsynth -F $MP3_FILE /usr/share/sounds/sf2/FluidR3_GM.sf2 $MIDI_FILE
done

mkdir -p "$dest_dir" && mv "$source_dir"/*.mp3 "$dest_dir"

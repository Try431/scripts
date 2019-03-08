#!/bin/bash

for file in $HOME/Downloads/ACC_midis/*.mid; do
	FILENAME=$(echo $file | cut -d . -f 1)
	MIDI_FILE=$FILENAME.mid
	MP3_FILE=$FILENAME.mp3
	fluidsynth -F $MP3_FILE /usr/share/sounds/general-user/GeneralUser_GS_v1.471.sf2 $MIDI_FILE
done

mv ~/Downloads/ACC_midis/*.mp3 ~/Downloads/ACC_mp3s/
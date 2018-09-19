#!/bin/bash

newSink="$1"

pactl list short sink-inputs | while read stream; do 
	streamId=$(echo $stream | cut '-d ' -f1)
	pactl move-sink-input "$streamId" "$newSink"
done

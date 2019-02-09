#!/bin/bash

newSink="$1"

pactl list short sink-inputs | while read stream; do 
	streamId=$(echo $stream | cut '-d ' -f1)
	pactl move-sink-input "$streamId" "$newSink"
done

# Changes $audio_sink i3 variable to new sink so I can change HDMI volume with Fn keys
sed -i -e 's/set \$audio_sink .*/set \$audio_sink '$newSink'/' ~/.config/i3/config
# Changes sink in polybar so polybar will show correct audio sink volume
sed -i -e 's/sink = .*/sink = '$newSink'/' ~/.config/polybar/config
echo $newSink
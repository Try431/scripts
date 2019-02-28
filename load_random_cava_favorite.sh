#!/bin/bash

LINE_COUNT=$(wc -l < ~/.config/cava/saved_gradients.txt)
RAND=$RANDOM; (( RAND < 32760 ))
RAND=$(((RAND%LINE_COUNT)+1))
# echo $RAND >> ~/.config/cava/saved_gradients.txt
if [[ RAND%2 -eq 0 ]]; then
	LINE_1=$((RAND - 1))
	LINE_2=$RAND
elif [[ RAND%2 -eq 1 ]]; then
	LINE_1=$RAND
	LINE_2=$((RAND + 1))
fi

GRAD_1=#$(sed -n ''$LINE_1'p' < ~/.config/cava/saved_gradients.txt | cut -d \# -f 2)
GRAD_2=#$(sed -n ''$LINE_2'p' < ~/.config/cava/saved_gradients.txt | cut -d \# -f 2)
echo $GRAD_1
echo $GRAD_2

sed -i -e 's/^gradient_color_1 = ".*"/gradient_color_1 = "'$GRAD_1'"/' ~/.config/cava/config
sed -i -e 's/^gradient_color_2 = ".*"/gradient_color_2 = "'$GRAD_2'"/' ~/.config/cava/config

CAVA_SOURCE_NAME=`pacmd list-sink-inputs | grep -e "sink: \<.*\>" | head -n 1| cut -f2 -d"<" | cut -f1 -d">"` 
pkill -USR1 cava # This reloads the configuration file, similar to pressing 'r' (see Cava README)
while [ -z "$CAVA_SINK_INDEX" ]
do
	sleep 1s
	# https://stackoverflow.com/a/48070534/3614985
	CAVA_SINK_INDEX=`pacmd list-source-outputs |  tr '\n' '\r' | perl -pe 's/ *index: ([0-9]+).+?application\.name = "([^\r]+)"\r.+?(?=index:|$)/\2:\1\r/g' | tr '\r' '\n' | grep cava | cut -f2 -d":"`
done
CAVA_SOURCE_NAME="$CAVA_SOURCE_NAME.monitor"
# echo $CAVA_SOURCE_NAME
pacmd move-source-output $CAVA_SINK_INDEX $CAVA_SOURCE_NAME
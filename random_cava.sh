sed -i -e 's/^gradient_color_1 = ".*"/gradient_color_1 = "#'$(openssl rand -hex 3)'"/' ~/.config/cava/config
sed -i -e 's/^gradient_color_2 = ".*"/gradient_color_2 = "#'$(openssl rand -hex 3)'"/' ~/.config/cava/config

CAVA_SOURCE_NAME=`pacmd list-sink-inputs | grep -e "sink: \<.*\>" | head -n 1| cut -f2 -d"<" | cut -f1 -d">"` 
pkill -USR1 cava # This reloads the configuration file, similar to pressing 'r' (see Cava README)
COUNT=0
# while [ -z "$CAVA_SINK_INDEX" ]
until [ "$COUNT" -le 1 ]
do
	# sleep 1s
	# https://stackoverflow.com/a/48070534/3614985
	CAVA_SINK_INDEX=`pacmd list-source-outputs |  tr '\n' '\r' | perl -pe 's/ *index: ([0-9]+).+?application\.name = "([^\r]+)"\r.+?(?=index:|$)/\2:\1\r/g' | tr '\r' '\n' | grep cava | cut -f2 -d":"`
	COUNT=$((COUNT+1))
	echo $COUNT
done
CAVA_SOURCE_NAME="$CAVA_SOURCE_NAME.monitor"
# echo $CAVA_SOURCE_NAME
pacmd move-source-output $CAVA_SINK_INDEX $CAVA_SOURCE_NAME
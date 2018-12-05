sed -i -e 's/^gradient_color_1 = ".*"/gradient_color_1 = "#'$(openssl rand -hex 3)'"/' ~/.config/cava/config
sed -i -e 's/^gradient_color_2 = ".*"/gradient_color_2 = "#'$(openssl rand -hex 3)'"/' ~/.config/cava/config
pkill -USR1 cava # This reloads the configuration file, similar to pressing 'r' (see README)
while [ -z "$CAVA_SINK_INDEX" ]
do
	sleep 1s
	CAVA_SINK_INDEX=`pacmd list-source-outputs |  tr '\n' '\r' | perl -pe 's/ *index: ([0-9]+).+?application\.name = "([^\r]+)"\r.+?(?=index:|$)/\2:\1\r/g' | tr '\r' '\n' | grep cava | cut -f2 -d":"`
done
pacmd move-source-output $CAVA_SINK_INDEX alsa_output.pci-0000_00_1f.3.analog-stereo.monitor
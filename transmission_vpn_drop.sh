#!/bin/bash

PID=$(pidof transmission-gtk)
export DISPLAY=:0
# https://unix.stackexchange.com/a/485719/169049
# https://askubuntu.com/a/928979/411064
export XDG_RUNTIME_DIR=/run/user/$(id -u)
# if nordvpn is disconnected and the PID variable is non-zero
if nordvpn status | grep -q "Status: Disconnected" && [[ ! -z "$PID" ]] ; then
	/usr/bin/notify-send "VPN Kill" "VPN Disconnected -- Killing Transmission ($PID)"
	kill $PID
fi

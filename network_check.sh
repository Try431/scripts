#!/bin/bash

ping -c 1 8.8.8.8
received=$?
echo $received
if [[ $received -ne 0 ]] ; then
	# echo $received > /home/isaac/scripts/rcc.txt
	# echo "heyo"
	# systemctl restart network-manager
	service network-manager restart
fi
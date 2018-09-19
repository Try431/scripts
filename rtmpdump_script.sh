#!/bin/bash

echo "What's the course number? (e.g., 6.046)"
read course

#Example URL: http://amps-web.amps.ms.mit.edu/courses/6/6.046/2017spring/L01/MIT-6.046-lec-mit-0000-2017feb09-1103-L01/
echo "Paste (CTRL+SHIFT+V) URL of lecture video."
read url
sfx="settings-flash.xml"
url="$url$sfx"

xml=$(curl -s $url)
xml=${xml#*HD\">} # Deletes shortest match of '*HD\">' substring from front of $xml.
xml=${xml%%<*} # Deletes longest match of '<*' substring from back of $xml
ppath=${xml#*$course/}

echo "Please type desired file name (e.g., Lec_01.mp4)"
read filename

#TODO
filepath="/media/isaac/Data/MIT/Academics/Spring_2017/6.046/Lecture_Videos/"

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "%%% Saving file to $filepath/$filename %%%"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

rtmpdump -r "rtmp://flashsvr1.amps.ms.mit.edu/$course" -o "$filepath/$filename" --playpath "$ppath"


# Docs for shell string manipulation: http://tldp.org/LDP/abs/html/string-manipulation.html

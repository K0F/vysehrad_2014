#!/bin/bash
PATH=$PATH:/home/kof/bin
export PATH
sleep 8
xinit &
sleep 1
export DISPLAY=:0.0
xset s off
xset -dpms

xrandr --output CRT1 --mode 1920x1080 --primary --output DFP1 --right-of CRT1 --mode 1280x720
#xrandr --output CRT1 --mode 1280x720 --primary --output DFP1 --right-of CRT1 --mode 1920x1080
xdotool mousemove 0 1080
rm /tmp/ctl || echo "Fifo is not there.. OK"
cd /home/kof/vysehrad/prehravac
/home/kof/bin/pp &

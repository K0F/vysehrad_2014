#!/bin/bash
xinit &
sleep 1
export DISPLAY=:0.0
xset s off
xset -dpms
xrandr --output CRT1 --mode 1280x720 --primary --output DFP1 --right-of CRT1 --mode 1920x1080
#xrandr --output VGA-0 --mode 1280x720 --output HDMI-0 --right-of VGA-0 --mode 1920x1080
xdotool mousemove 1280 720
rm /tmp/ctl || echo "Fifo is not there.. OK"
cd /home/kof/vysehrad/prehravac
/home/kof/bin/pp &

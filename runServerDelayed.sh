#!/bin/bash
PATH=$PATH:/home/kof/bin
export PATH
sleep 8
xinit &
sleep 1
export DISPLAY=:0.0
xset s off
xset -dpms
#xrandr --output VGA-0 --mode 1280x720 --output HDMI-0 --right-of VGA-0 --mode 1920x1080
xdotool mousemove 1280 720
rm /tmp/ctl || echo "Fifo is not there.. OK"
cd /home/kof/vysehrad/prehravac
/home/kof/bin/pp &

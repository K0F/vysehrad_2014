#!/bin/bash
xinit &
sleep 1
export DISPLAY=:0.0
xset s off
xset -dpms
xdotool mousemove 1024 768
rm /tmp/ctl || echo "Fifo is not there.. OK"
cd /home/kof/vysehrad/prehravac
/home/kof/bin/pp &

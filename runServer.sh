#!/bin/bash
xinit &
sleep 1
export DISPLAY=:0.0
rm /tmp/ctl || echo "Fifo is not there.. OK"
#Xvfb :1 -screen 0 1024x768x24 &
#export DISPLAY=:1.0
cd /home/kof/vysehrad/prehravac
/home/kof/bin/pp &

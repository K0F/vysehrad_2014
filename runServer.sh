#!/bin/bash
masskill mplayer
masskill Xvfb
Xvfb :1 -screen 0 1024x768x24 &
export DISPLAY=:1.0
cd /home/kof/vysehrad/prehravac
/home/kof/bin/pp &
mplayer -vo fbdev ~/test.mp4

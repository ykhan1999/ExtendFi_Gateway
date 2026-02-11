#!/usr/bin/bash
pkill -f "disp_loading_bar.sh" || true
cd /usr/local/bin
oled r
oled +1 "Connect to WiFi"
oled +2 "Name: ExtendFi"
oled +4 "Help? See video"
oled s
cd -

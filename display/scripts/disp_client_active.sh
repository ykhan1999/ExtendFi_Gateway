#!/usr/bin/bash
pkill -f "disp_loading_bar.sh" || true
cd /usr/local/bin
DEBUG="0"
STATUS=""

i=60
while true; do
  #get signal strength
  Signal=$(morse_cli -i wlan1 stats | grep Received | grep -Po '\-[[:digit:]]+')
  if [ "$DEBUG" -eq "1" ]; then
    signalstatus="$Signal"
  else
    if [ "$Signal" -ge "-30" ]; then
      signalstatus="********"
    elif [ "$Signal" -ge "-40" ] && [ "$Signal" -lt "-30" ]; then
      signalstatus="*******"
    elif [ "$Signal" -ge "-50" ] && [ "$Signal" -lt "-40" ]; then
      signalstatus="******"
    elif [ "$Signal" -ge "-60" ] && [ "$Signal" -lt "-50" ]; then
      signalstatus="*****"
    elif [ "$Signal" -ge "-70" ] && [ "$Signal" -lt "-60" ]; then
      signalstatus="****"
    elif [ "$Signal" -ge "-80" ] && [ "$Signal" -lt "-70" ]; then
      signalstatus="***"
    elif [ "$Signal" -ge "-90" ] && [ "$Signal" -lt "-80" ]; then
      signalstatus="LOW"
    elif [ "$Signal" -ge "-100" ] && [ "$Signal" -lt "-90" ]; then
      signalstatus="LOW"
    elif [ "$Signal" -lt "-100" ]; then
      sleep 1
      if [ "$Signal" -lt "-100" ]; then
        sleep 1
        if [ "$Signal" -lt "-100" ]; then
        signalstatus="None"
        fi
      fi
    fi
  fi
  #update internet and connectivity status every minute
  if [[ "$i" -ge 59 ]]; then
    if ping -c1 -W2 8.8.8.8 &>/dev/null; then
      STATUS="CONNECTED"
    elif ping -c1 -W2 192.160.50.1 &>/dev/null; then
      STATUS="NO INTERNET"
    else
      STATUS="NO GATEWAY"
    fi
    SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    oled +2 "${SSID}"
    oled +3 "$STATUS"
    oled s
    i=0
  fi
  #update signal status every second
  oled +4 "Signal: $signalstatus"
  oled s
  #loop timer
  sleep 1
  i=$(($i+1))
done
cd -

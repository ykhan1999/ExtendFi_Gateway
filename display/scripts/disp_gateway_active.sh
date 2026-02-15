#!/usr/bin/bash
pkill -f "disp_loading_bar.sh" || true
cd /usr/local/bin
prev_internet=""
prev_signal=""
prev_peers=""
DEBUG="0"
INTERNET=""

i=60
while true; do
  #get SSID
  SSID=$(iwgetid -r)
  #get signal strength
  Signal=$(iw dev wlan0 link | awk '/signal:/ {print $2}')
  if [ "$DEBUG" -eq "1" ]; then
    signalstatus="$Signal"
  else
    if [ "$Signal" -ge "-30" ]; then
      signalstatus="********"
      j=0
    elif [ "$Signal" -ge "-40" ] && [ "$Signal" -lt "-30" ]; then
      signalstatus="*******"
      j=0
    elif [ "$Signal" -ge "-50" ] && [ "$Signal" -lt "-40" ]; then
      signalstatus="******"
      j=0
    elif [ "$Signal" -ge "-60" ] && [ "$Signal" -lt "-50" ]; then
      signalstatus="*****"
      j=0
    elif [ "$Signal" -ge "-70" ] && [ "$Signal" -lt "-60" ]; then
      signalstatus="****"
      j=0
    elif [ "$Signal" -ge "-80" ] && [ "$Signal" -lt "-70" ]; then
      signalstatus="***"
      j=0
    elif [ "$Signal" -ge "-90" ] && [ "$Signal" -lt "-80" ]; then
      signalstatus="LOW"
      j=0
    elif [ "$Signal" -ge "-100" ] && [ "$Signal" -lt "-90" ]; then
      signalstatus="LOW"
      j=0
    elif [ "$Signal" -lt "-100" ]; then
      j=$(($j+1))
      if [[ "$j" -ge 5 ]]; then
        signalstatus="None"
      fi
    fi
  fi
  #get number of peers
  Peers=$(journalctl -u 80211s_serve_dns.service --since "2 min ago" | grep -Po "192\\.168\\.50\\.[0-9]+" | sort -u | wc -l)
  #get connectivity state
  if [[ "$i" -ge 15 ]]; then
    if ping -c1 -W2 8.8.8.8 &>/dev/null; then
      INTERNET="CONNECTED"
    else
      INTERNET="NO INTERNET"
    fi
    i=0
  fi
  #refresh screen only with change
  if [ "$INTERNET" != "$prev_internet" ] || [ "$signalstatus" != "$prev_signal" ] || [ "$Peers" != "$prev_peers" ]; then
    oled +2 "${INTERNET}"
    oled +4 "SIGNAL: $signalstatus"
    oled +3 "EXTENDERS: ${Peers}"
    oled s
  fi
  #store new variables to check for change
  prev_internet="$INTERNET"
  prev_signal="$signalstatus"
  prev_peers="$Peers"
  #loop timer
  sleep 1
  i=$(($i+1))
done
cd -

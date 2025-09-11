#!/bin/bash

while true; do
    # Volume (pamixer or amixer)
    if pamixer --get-mute | grep -q true; then
      VOL="MUTE ($(pamixer --get-volume)%)"
    else
      VOL="$(pamixer --get-volume)%"
    fi
    #VOL=$(pamixer --get-volume-human 2>/dev/null || amixer get Master | awk -F'[][]' 'END{print $2}')

    # Battery
    BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "--")

    # CPU usage (average over 1 second)
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

    # RAM usage
    MEM=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')

    # Date + Time
    DATE=$(date "+%a %d %b %H:%M")

    # Update dwm bar
    xsetroot -name "VOL:$VOL | BAT:$BAT% | CPU:$CPU | RAM:$MEM | $DATE"

    sleep 1
done


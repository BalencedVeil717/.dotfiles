#!/bin/bash
# DWM status bar script
# Updates volume, battery, and date/time

# Function to update the status
update_status() {
    # Volume (pamixer)
    VOL=$(pamixer --get-volume-human 2>/dev/null || echo "--")

    # Battery
    BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "--")

    # Date + Time
    DATE=$(date "+%a %d %b %H:%M")

    # Update dwm bar
    xsetroot -name "VOL:$VOL | BAT:$BAT% | $DATE"
}

# Run once at start
update_status

# Update instantly when volume changes
pactl subscribe | while read -r event; do
    case "$event" in
        *"sink"*) update_status ;;
    esac
done &

# Update every full minute
while true; do
    sleep $((60 - $(date +%S)))
    update_status
done &

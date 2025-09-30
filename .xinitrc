#!/bin/sh

# Wallpaper
feh --bg-scale ~/.dotfiles/.config/wallpapers/m3-macx.jpg &

# Compositor
#picom --config ~/.config/picom/picom.conf &

# ---- DWM bar logic ----
update_status() {
    # Volume (pamixer or amixer)
    if pamixer --get-mute | grep -q true; then
      VOL="MUTE ($(pamixer --get-volume)%)"
    else
      VOL="$(pamixer --get-volume)%"
    fi

    # Battery
    BAT=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "--")

    # CPU usage
    #CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

    # RAM usage
    #MEM=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')

    # Date + Time
    DATE=$(date "+%a %d %b %H:%M")

    # Update dwm bar
    #xsetroot -name "VOL:$VOL | BAT:$BAT% | CPU:$CPU | RAM:$MEM | $DATE"
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

# ---- End DWM bar ----

# Start dwm
exec dwm


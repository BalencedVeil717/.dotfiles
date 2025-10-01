#!/bin/sh

# Wallpaper
feh --bg-scale ~/.dotfiles/.config/wallpapers/m3-macx.jpg &

# Compositor
picom --config ~/.config/picom/picom.conf &

# Start status bar
dwmbar.sh &

# Start dwm
exec dwm

#!/bin/sh

# Wallpaper
feh --bg-scale ~/.dotfiles/.config/wallpapers/m3-macx.jpg &

# Compositor
picom --config ~/.config/picom/picom.conf &

# Start status bar
~/.local/bin/dwmbar.sh &

# Start dwm
exec dwm

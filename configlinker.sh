#!/bin/bash
set -e
cd ~/.dotfiles

# Linking .config directories
config_dirs=(
    .config/alacritty
    .config/btop
    .config/dmenu
    .config/dwm
    .config/st
    .config/systemd
    .config/wallpapers
)

for dir in "${config_dirs[@]}"; do
    ln -sf "$PWD/$dir" "$HOME/.config/$(basename "$dir")"
done

# Linking home directory dotfiles
home_files=(
    .bashrc
    .bash_profile
    .xinitrc
)

for file in "${home_files[@]}"; do
    ln -sf "$PWD/$file" "$HOME/$file"
done


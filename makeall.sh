#!/bin/bash

# Directories to build
dirs=(
  "$HOME/.config/dwm"
  "$HOME/.config/dmenu"
)

for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "Entering $dir"
        cd "$dir" || exit 1
        echo "Running: sudo make clean install"
        sudo make clean install || { echo "Failed in $dir"; exit 1; }
        echo "Running: make clean"
        make clean || { echo "Failed clean in $dir"; exit 1; }
    else
        echo "Directory $dir not found, skipping."
    fi
done

echo "All builds completed!"

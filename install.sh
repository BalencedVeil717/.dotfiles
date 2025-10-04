#!/bin/bash
set -e

# === CONFIG ===
DOTFILES="$HOME/.dotfiles"

# === Helper Functions ===
link() {
    src=$1
    dest=$2
    echo "Linking $src → $dest"
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
}

install_pkglist() {
    echo ">>> Installing packages from pkglist.txt..."
    if [ -f "$DOTFILES/pkglist.txt" ]; then
        sudo pacman -Syu --needed --noconfirm - < "$DOTFILES/pkglist.txt"
    else
        echo "pkglist.txt not found in $DOTFILES"
        echo ">>> Installing suggested fallback packages..."
        sudo pacman -Syu --needed --noconfirm \
            base-devel git xorg xorg-xinit \
            alacritty feh picom pamixer pulseaudio pulseaudio-alsa networkmanager \
            dmenu lf nano \
            noto-fonts noto-fonts-emoji \
            ttf-jetbrains-mono ttf-jetbrains-mono-nerd
    fi
}

# === Install Packages ===
install_pkglist

# === Clone or update dotfiles repo ===
# if [ ! -d "$DOTFILES" ]; then
#     echo "[*] Cloning dotfiles repo..."
#     git clone https://github.com/yourusername/dotfiles.git "$DOTFILES"
# else
#     echo "[*] Updating dotfiles repo..."
#     git -C "$DOTFILES" pull
# fi

# === Symlinks ===
echo "[*] Creating symlinks..."

# Config dirs
config_dirs=(alacritty btop dmenu dwm st systemd wallpapers)
for dir in "${config_dirs[@]}"; do
    link "$DOTFILES/.config/$dir" "$HOME/.config/$dir"
done

# Home files
home_files=(.bashrc .bash_profile .xinitrc)
for file in "${home_files[@]}"; do
    link "$DOTFILES/$file" "$HOME/$file"
done

# Local bin scripts
mkdir -p "$HOME/.local/bin"
link "$DOTFILES/.local/bin/dwmbar.sh" "$HOME/.local/bin/dwmbar.sh"
chmod +x "$HOME/.local/bin/dwmbar.sh"

# === Build dwm, dmenu, st ===
for prog in dwm dmenu st; do
    echo "[*] Building $prog..."
    sudo make -C "$DOTFILES/.config/$prog" clean install
done

# === Done ===
echo ">>> Install complete! Run 'startx' to launch dwm."

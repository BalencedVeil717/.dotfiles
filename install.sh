
set -e

# === CONFIG ===
DOTFILES="$HOME/.dotfiles"

# === Helper ===
link() {
    src=$1
    dest=$2
    echo "Linking $src → $dest"
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
}

# === Packages ===
echo "[*] Installing required packages..."
sudo pacman -Syu --needed --noconfirm base-devel git xorg xorg-xinit alacritty feh picom pamixer pulseaudio pulseaudio-alsa networkmanager dmenu alacritty lf nano noto-fonts-emoji ttf-jetbrains-mono ttf-jetbrains-mono-nerd noto-fonts
# === Dotfiles ===
if [ ! -d "$DOTFILES" ]; then
    echo "[*] Cloning dotfiles repo..."
    git clone https://github.com/yourusername/dotfiles.git "$DOTFILES"
else
    echo "[*] Updating dotfiles repo..."
    git -C "$DOTFILES" pull
fi

# === Symlinks ===
echo "[*] Creating symlinks..."
link "$DOTFILES/.config/alacritty" "$HOME/.config/alacritty"
link "$DOTFILES/.config/dwm"       "$HOME/.config/dwm"
link "$DOTFILES/.local/bin"        "$HOME/.local/bin"
# Add more as needed...

# === Build dwm (and dmenu/st) ===
echo "[*] Building dwm..."
make -C "$DOTFILES/.config/dwm" clean install

# === Done ===
echo "🎉 Install complete! You can now startx or log into dwm."

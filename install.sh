#!/bin/bash

DOTFILES="$HOME/.dotfiles"

# ---------------------------
# Helpers
# ---------------------------
link() {
    src="$1"
    dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "⚠️  Backing up $dest to $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    echo "🔗 Linking $src → $dest"
    ln -sf "$src" "$dest"
}

# ---------------------------
# Install packages
# ---------------------------
install_packages() {
    if [ -f "$DOTFILES/pkglist.txt" ]; then
        echo "📦 Installing packages from pkglist.txt..."
        sudo pacman -S --needed - < "$DOTFILES/pkglist.txt"
    fi
}

# ---------------------------
# Setup shell
# ---------------------------
setup_shell() {
    echo "🖥️ Setting up shell configs..."
    link "$DOTFILES/shell/.bashrc" "$HOME/.bashrc"
    link "$DOTFILES/shell/.bash_profile" "$HOME/.bash_profile"
}

# ---------------------------
# Setup xinitrc
# ---------------------------
setup_xinit() {
    echo "🖼️ Setting up .xinitrc..."
    link "$DOTFILES/.xinitrc" "$HOME/.xinitrc"
}

# ---------------------------
# Setup xinitrc
# ---------------------------

build_dwm_suite() {
    echo "⚒️ Building [ dwm | dmenu ]"

    for dir in dwm dmenu; do
        if [ -d "$DOTFILES/.config/$dir" ]; then
            echo "➡️  Building $dir..."
            (cd "$DOTFILES/.config/$dir" && sudo make clean install)
        else
            echo "❌ $dir not found in $DOTFILES/.config/"
        fi
    done
}


# ---------------------------
# Main
# ---------------------------
install_packages
setup_shell
setup_xinit
build_dwm_suite

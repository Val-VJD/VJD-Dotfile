#!/bin/bash

# Generate accent color via pywal

wal -i $1

# Copy the current wallpaper

LINK="$HOME/.config/waypaper/current.png"

[ -L "$LINK" ] && rm "$LINK"
mkdir -p "$(dirname "$LINK")"
cp "$1" "$LINK"

# Copy a pywal css to UI element directory.

copywalcss() {
    DIR="$1"
    CSSFILE="$HOME/.cache/wal/colors.css"

    [ -L "$DIR/colors.css" ] && rm "$DIR/colors.css"
    mkdir -p "$DIR"          # make sure the directory exists
    cp "$CSSFILE" "$DIR/colors.css"
}

copywalcss "$HOME/.config/waybar/"
copywalcss "$HOME/.config/swaync/"
copywalcss "$HOME/.config/nwg-dock-hyprland/"
copywalcss "$HOME/.config/wlogout/"

# Restart UI elements

~/.config/hypr/scripts/uistartup.sh
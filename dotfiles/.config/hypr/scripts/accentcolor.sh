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
    CSSFILE="$HOME/.cache/wal/colors-waybar.css"

    mkdir -p "$DIR"
    [ -e "$DIR/pywal.css" ] && rm -f "$DIR/pywal.css"
    cp "$CSSFILE" "$DIR/pywal.css"
}

copywalcss "$HOME/.config/waybar/colors"
copywalcss "$HOME/.config/swaync/colors"
copywalcss "$HOME/.config/nwg-dock-hyprland/colors"
copywalcss "$HOME/.config/wlogout/colors"

# Restart UI elements

~/.config/hypr/scripts/uistartup.sh
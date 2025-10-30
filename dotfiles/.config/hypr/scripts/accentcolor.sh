#!/bin/bash

# Generate accent color via pywal

wal -i $1

# Restart UI elements

~/.config/hypr/scripts/uistartup.sh

# Generate a symlink to the Wallpaper

LINK=$HOME/.config/waypaper/current.png

[ -L "$LINK" ] && rm "$LINK"
ln -s "$1" "$LINK"

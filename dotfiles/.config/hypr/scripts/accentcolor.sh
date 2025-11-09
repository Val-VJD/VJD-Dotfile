#!/bin/bash

export PATH="$HOME/.local/bin:$PATH"

MATUGEN_PATH=$(which matugen)

if [ -z "$MATUGEN_PATH" ]; then
    echo "Error: matugen executable not found in $HOME/.local/bin or the PATH." >&2
    exit 1
fi

# Copy the current wallpaper (Keep $HOME to ensure portability)
LINK="$HOME/.config/waypaper/current.png"
[ -L "$LINK" ] && rm "$LINK"
mkdir -p "$(dirname "$LINK")"
cp "$1" "$LINK"

# Generate accent color via Matugen
"$MATUGEN_PATH" image "$1"

# Set Hyprpanel colors
hyprpanel setWallpaper "$1"

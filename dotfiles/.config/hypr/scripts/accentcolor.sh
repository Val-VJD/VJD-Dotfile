#!/bin/bash

export PATH="$HOME/.local/bin:$PATH"

MATUGEN_PATH=$(which matugen)

if [ -z "$MATUGEN_PATH" ]; then
    echo "Error: matugen executable not found in $HOME/.local/bin or the PATH." >&2
    exit 1
fi

# Generate accent color via Matugen
"$MATUGEN_PATH" image "$1"

# Copy the current wallpaper
LINK="$HOME/.config/waypaper/current.png"
[ -L "$LINK" ] && rm "$LINK"
[ -f "$LINK" ] && rm "$LINK"
ffmpeg -y -i "$1" "$LINK" < /dev/null
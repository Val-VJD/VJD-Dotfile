#!/bin/bash

# Load Pywal colors
if [ -f ~/.cache/wal/colors.sh ]; then
    source ~/.cache/wal/colors.sh
else
    echo "Pywal colors not found. Run: wal -i /path/to/image"
    exit 1
fi

# Convert hex #rrggbb → rgba(rrggbbaa)
to_rgba() {
    echo "rgba(${1:1}ff)"
}

# Apply Pywal colors to Hyprland borders
hyprctl keyword general:col.inactive_border "$(to_rgba $color5)" # Inactive windows


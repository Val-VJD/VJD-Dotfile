#!/bin/bash

# Kills existing ui elements, then then starts them again

# Kills programs
killall waybar nwg-dock-hyprland 2>/dev/null

sleep 0.5

# Refresh SwayNC

swaync-client -rs

# Restart programs

waybar &
nwg-dock-hyprland -x -mb 10 -i 30 -c "nwg-drawer -mb 7 -ml 7 -mr 7 -mt 7" & # Put a hashtag (#) before this if you don't want a dock.


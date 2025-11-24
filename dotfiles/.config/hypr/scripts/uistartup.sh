#!/bin/bash

# Kills existing ui elements, then then starts them again

# Kills programs
killall waybar nwg-dock-hyprland 2>/dev/null

sleep 0.5

# Refresh SwayNC

swaync-client -rs

# Restart programs

waybar &
nwg-dock-hyprland -x -mb 4 -mt -4 -i 24 -c "nwg-drawer -mb 75 -ml 200 -mr 200 -mt 75" & # Put a hashtag (#) before this if you don't want a dock.


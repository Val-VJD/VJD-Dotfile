#!/bin/bash

# Kills existing ui elements, then then starts them again

# Kills programs
killall waybar nwg-dock-hyprland cava 2>/dev/null

sleep 0.5

# Refresh SwayNC

swaync-client -rs

# Restart programs

waybar &

# Tip, remove -d from nwg-dock-hyprland to make the dock static,
# Add -d back to make it autohide

nwg-dock-hyprland -x -f -p "left" -hd 60 -mb 10 -mt 10 -ml 10 -i 24 -c "nwg-drawer -mb 150 -ml 350 -mr 350 -mt 150" & # Put a hashtag (#) before this if you don't want a dock.


#!/bin/bash

# Apply wallpaper using wal
wal -b 282738 -i ~/Wallpaper/Aesthetic2.png &&

# Start picom
picom --config ~/.config/picom/picom.conf &

# input method
fcitx5 -d

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Load notification service
dunst &


# Setup Wallpaper and update colors
~/.config/qtile/scripts/wallpaper.sh init
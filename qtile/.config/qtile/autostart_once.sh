#!/bin/bash

# Apply wallpaper using wal
# wal -b 282738 -i ~/Wallpaper/Aesthetic2.png &&

# input method
fcitx5 -d

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Load notification service
dunst &

# Setup Wallpaper and update colors
nitrogen --restore &

# status bar
polybar mybar &

# screensave
xidlehook \
    --not-when-audio \
    --not-when-fullscreen \
    --timer 1200 \
    'betterlockscreen -l dimblur -- --clock' \
    '' &

# monitor
xrandr --output DisplayPort-0 \
    --mode 2560x1440 \
    --rate 180 \
    --pos 0x0 \
    --scale 1x1 

blueman-applet &

# Load picom
# picom &
sleep 1
if ! pgrep -x "picom" > /dev/null; then
    picom -b --config ~/.config/picom/picom.conf
fi


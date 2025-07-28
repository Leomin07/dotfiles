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
nitrogen --restore &



# Tự động khóa màn hình sau 5 phút không hoạt động
xidlehook \
  --not-when-audio \
  --not-when-fullscreen \
  --timer 1200 \
    'betterlockscreen -l dimblur -- --clock' \
    '' &

# monitor
xrandr --output DP-1 \
       --mode 2560x1440 \
       --rate 180 \
       --pos 0x0 \
       --scale 1x1 \
       --depth 10
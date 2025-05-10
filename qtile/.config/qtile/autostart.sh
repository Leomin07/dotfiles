#!/bin/bash
# Autostart script for Qtile

# Keyboard layout
setxkbmap us

# Bluetooth
blueman-applet &

# Notification
dunst &

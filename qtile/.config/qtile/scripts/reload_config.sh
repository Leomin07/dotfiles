#!/bin/bash
# Reload Qtile and restart polybar

qtile cmd-obj -o cmd -f reload_config
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done
polybar mybar -c ~/.config/polybar/config.ini &

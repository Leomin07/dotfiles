#!/bin/bash

# volume_notify.sh up|down|mute

STEP="5%"

get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1
}

case "$1" in
up)
    pactl set-sink-volume @DEFAULT_SINK@ +$STEP
    notify-send -t 1000 "🔊 Volume Up" "$(get_volume)"
    ;;
down)
    pactl set-sink-volume @DEFAULT_SINK@ -$STEP
    notify-send -t 1000 "🔉 Volume Down" "$(get_volume)"
    ;;
mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    if [ "$muted" = "yes" ]; then
        notify-send -t 1000 "🔇 Muted"
    else
        notify-send -t 1000 "🔈 Unmuted" "$(get_volume)"
    fi
    ;;
esac

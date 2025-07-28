#!/usr/bin/env bash

# ───────────────────────────────────────────────────────────────
#                          Power Options
# ───────────────────────────────────────────────────────────────

options=(
    "lock:  Lock"
    "suspend:  Suspend"
    "logout:  Logout"
    "reboot:  Reboot"
    "shutdown:  Shutdown"
)

username=" $(whoami)"
messages=("See ya!" "Adiós, amigo!" "Catch you on the flip side!" "Powering down..." "Peace out!")
sendoff="${messages[$((RANDOM % ${#messages[@]}))]}"

# Theme rofi
theme="$HOME/.config/rofi/themes/catppuccin-mocha.rasi"

# ───────────────────────────────────────────────────────────────
#                            Rofi UI
# ───────────────────────────────────────────────────────────────

rofi_cmd() {
    rofi -dmenu \
        -p "$username" \
        -mesg "$sendoff" \
        -theme "$theme"
}

run_rofi() {
    printf "%s\n" "${options[@]}" | cut -d: -f2 | rofi_cmd
}

# ───────────────────────────────────────────────────────────────
#                        Run Commands
# ───────────────────────────────────────────────────────────────

run_cmd() {
    case "$1" in
        shutdown)
            systemctl poweroff
            ;;
        reboot)
            systemctl reboot
            ;;
        suspend)
            mpc -q pause 2>/dev/null
            amixer set Master mute
            systemctl suspend
            ;;
        logout)
            pkill -KILL -u "$USER"
            ;;
        lock)
            if command -v betterlockscreen &>/dev/null; then
                betterlockscreen -l
            elif command -v i3lock &>/dev/null; then
                i3lock
            else
                notify-send "No lock tool found."
            fi
            ;;
        *)
            notify-send "Invalid option: $1"
            ;;
    esac
}

# ───────────────────────────────────────────────────────────────
#                          Main Menu
# ───────────────────────────────────────────────────────────────

chosen="$(run_rofi)"

# Get the action (key before colon) that matches the chosen label
action=$(printf "%s\n" "${options[@]}" | grep -F ":$chosen" | cut -d: -f1)

# Only run if action is not empty
if [[ -n "$action" ]]; then
    run_cmd "$action"
else
    notify-send "No action selected or invalid selection."
fi

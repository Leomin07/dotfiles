#!/bin/bash

# Path thư mục chứa ảnh nền
wallDIR="$HOME/Pictures/wallpaper"

# File cache lưu lại hình nền hiện tại
CACHE="$HOME/.cache/wal/current_wallpaper"

# Command rofi chọn hình nền
rofi_command="rofi -dmenu -i -config ~/.config/rofi/wallpaper-select.rasi"

# Lấy danh sách ảnh nền (tên + icon preview)
mapfile -t PICS < <(find "$wallDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

# Menu Rofi với preview icon
menu() {
    for pic in "${PICS[@]}"; do
        name=$(basename "$pic")
        printf "%s\x00icon\x1f%s\n" "$name" "$pic"
    done
}

# Hiển thị menu và chọn
choice=$(menu | $rofi_command)

# Nếu không chọn gì thì thoát
[ -z "$choice" ] && echo "No choice" && exit 0

# Tìm đúng path ảnh được chọn
for img in "${PICS[@]}"; do
    if [[ "$(basename "$img")" == "$choice" ]]; then
        selected="$img"
        break
    fi
done

# Nếu không tìm thấy thì báo lỗi
[ -z "$selected" ] && echo "Image not found" && exit 1

# Lưu ảnh đã chọn
echo "$selected" > "$CACHE"

# Áp dụng wal
wal -q -i "$selected"

# Reload lại Qtile (áp theme mới)
qtile cmd-obj -o cmd -f reload_config

# Notify
notify-send "Wallpaper Set" "$choice"

exit 0

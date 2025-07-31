#!/bin/bash

# Path thư mục chứa ảnh nền
wallDIR="$HOME/Pictures/wallpaper"

# File cache lưu lại hình nền hiện tại
CACHE="$HOME/.cache/wallpaper_current"

# Command rofi chọn hình nền
rofi_command="rofi -dmenu -i -config ~/.config/rofi/wallpaper-select.rasi"

# Lấy danh sách ảnh nền (tên + icon preview)
mapfile -t PICS < <(find "$wallDIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort)

# Hiển thị menu Rofi có icon preview
menu() {
    for pic in "${PICS[@]}"; do
        name=$(basename "$pic")
        printf "%s\x00icon\x1f%s\n" "$name" "$pic"
    done
}

# Lựa chọn từ rofi
choice=$(menu | $rofi_command)

# Nếu không chọn gì thì thoát
[ -z "$choice" ] && echo "No choice selected" && exit 0

# Tìm đúng path ảnh được chọn
for img in "${PICS[@]}"; do
    if [[ "$(basename "$img")" == "$choice" ]]; then
        selected="$img"
        break
    fi
done

# Nếu không tìm thấy thì thoát
[ -z "$selected" ] && echo "Image not found" && exit 1

# Lưu ảnh đã chọn
echo "$selected" > "$CACHE"

# Đặt ảnh nền bằng nitrogen
nitrogen --set-zoom-fill "$selected" --save

# Gửi thông báo
notify-send "Wallpaper Set" "$choice"

exit 0

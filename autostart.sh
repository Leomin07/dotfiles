#!/bin/bash
# Đường dẫn tới thư mục dotfiles
DOTFILES_DIR=~/dotfiles

# Kiểm tra thư mục dotfiles có tồn tại không
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Thư mục dotfiles không tồn tại tại $DOTFILES_DIR"
    exit 1
fi

# Xóa file .DS_Store trong thư mục đích để tránh xung đột
echo "Xóa .DS_Store trong ~/.config nếu có..."
find ~/.config -name ".DS_Store" -type f -delete

# Nếu thư mục ~/.config/alacritty đã tồn tại và không phải là symlink, hãy di chuyển nó
if [ -d ~/.config/alacritty ] && [ ! -L ~/.config/alacritty ]; then
    echo "Di chuyển thư mục ~/.config/alacritty sang ~/.config/alacritty_backup..."
    mv ~/.config/alacritty ~/.config/alacritty_backup
fi

# Chuyển đến thư mục dotfiles
cd "$DOTFILES_DIR" || exit

# Đồng bộ cấu hình sử dụng stow với tùy chọn adopt
echo "Đang đồng bộ cấu hình Alacritty..."
stow --adopt -t ~ .config

# Kiểm tra kết quả
if [ -L ~/.config/karabiner/karabiner.json ]; then
    echo "Đồng bộ cấu hình Alacritty thành công!"
else
    echo "Đồng bộ cấu hình Alacritty thất bại. Kiểm tra lại lỗi."
fi

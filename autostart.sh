[ -d ~/.config/alacritty ] || mkdir -p ~/.config/alacritty
mv ~/.dotfiles/.config/alacritty/ ~/.config/alacritty/alacritty.toml
stow alacritty

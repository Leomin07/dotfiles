### This is my Dotfiles config MacOS

```
cd ~/dotfiles
stow kitty
stow alacritty
stow nvim

ls -l ~/.config
```

### Fix

```
rm ~/.config/.DS_Store
```

```
find ./ -name ".DS_Store" -type f -delete
```

```
rm ~/.local/share/nvim
```

### test

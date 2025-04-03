```
cd ~/dotfiles
stow .config/alacritty
stow .config/karabiner
stow .config/kitty

ls -l ~/.config

```

### Fix

```
rm ~/.config/.DS_Store
```

```
find ./ -name ".DS_Store" -type f -delete
```

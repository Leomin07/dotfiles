## Dump shortcut

```
dconf dump /org/cinnamon/desktop/keybindings/ > ~/dotfiles/arch-linux/cinnamon_custom_keybindings.dconf
```

## Load shortcut

```
dconf load /org/cinnamon/desktop/keybindings/ < ~/dotfiles/arch-linux/cinnamon_custom_keybindings.dconf

```

## Disable recent files **nemo**

```
dconf write /org/gnome/desktop/privacy/remember-recent-files false
```

## Dump config nemo

```
 dconf dump /org/cinnamon/desktop/privacy/  > ~/dotfiles/arch-linux/config_nemo.dconf
```

## Load config nemo

```
 dconf load /org/cinnamon/desktop/privacy/  < ~/dotfiles/arch-linux/config_nemo.dconf
```

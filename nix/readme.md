### Enable flake

```
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

### Create symlink from dotfiles to /etc/nixos/configuration.nix

```
sudo ln -sf /home/leomin07/dotfile/nix/configuration.nix /etc/nixos/configuration.nix
```

### Specify path when using flake

```
sudo nixos-rebuild switch --flake ~/dotfile/nix#minhtd
```

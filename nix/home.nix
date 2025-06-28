{ config, pkgs, ... }:

{

  home.username = "minhtd";
  home.homeDirectory = "/home/minhtd";
  # --------------------------------------
  # CONFIGURATION SECTION: Variables, user, timezone, package lists (from your Arch script)
  # --------------------------------------

  # Allow installation of unfree/proprietary software (e.g. Chrome, VSCode, Brave...)
  nixpkgs.config.allowUnfree = true;

  # Set your timezone
  time.timeZone = "Asia/Ho_Chi_Minh";

  users.users.minhtd = {
    isNormalUser = true;
    # Add sudo, docker, virtualization access
    extraGroups = [ "wheel" "docker" "libvirt" ]; 
    shell = pkgs.zsh;
  };

  # Set up global git config and SSH key (these are best placed in home-manager, but can be scripted)
  # See https://nixos.wiki/wiki/Git for advanced setup

  # Install all your essential packages
  environment.systemPackages = with pkgs; [
    python3
    python3.pkgs.pip
    python3.pkgs.virtualenv
    tk
    ffmpeg
    vim
    neovim
    stow
    bat
    fzf
    tree
    ripgrep
    tldr
    kitty
    ghostty
    zoxide
    eza
    lazygit
    vscode
    discord
    mpv
    google-chrome
    dotnet-runtime_8
    fastfetch
    brave
    # balena-etcher
    postman
    dbeaver
    telegram-desktop
    lazydocker
    xclip
    # mission-center
    fcitx5
    fcitx5-configtool
    fcitx5-qt
    fcitx5-gtk
    fcitx5-bamboo
    # Fonts (uncomment if needed)
    # noto-fonts
    # noto-fonts-emoji
    # ttf-dejavu
    # ttf-roboto
    # ttf-liberation
    # adobe-source-han-sans-otc-fonts
    nodejs
    yarn
    virt-manager
  ];

  # Docker service
  virtualisation.docker.enable = true;

  # Libvirtd for virtualization
  virtualisation.libvirtd.enable = true;

  # Zsh & Oh My Zsh
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [
    "git"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "zsh-completions"
    "docker"
    "docker-compose"
    "z"
  ];

  # Starship prompt
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # Fcitx5 input method (Vietnamese)
  # i18n.inputMethod.enabled = "fcitx5";
  # i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-bamboo ];

  # Bluetooth support
  hardware.bluetooth.enable = true;

  # GNOME Keyring (if needed)
  services.gnome.gnome-keyring.enable = true;

  home.stateVersion = "25.05";

 }



#!/bin/bash

#  _      ______ ____  __  __ _____ _   _
# | |    |  ____/ __ \|  \/  |_   _| \ | |
# | |    | |__ | |  | | \  / | | | |  \| |
# | |    |  __|| |  | | |\/| | | | | . ` |
# | |____| |___| |__| | |  | |_| |_| |\  |
# |______|______\____/|_|  |_|_____|_| \_|

set -euo pipefail

# --- Configuration ---
TIMEZONE="Asia/Ho_Chi_Minh"
USER_NAME="MinhTD"
USER_EMAIL="tranminhsvp@gmail.com"
SSH_KEY_FILE="$HOME/.ssh/id_ed25519"
FISH_SHELL="/usr/bin/fish"
FISH_CONFIG_DIR="$HOME/.config/fish"
FISH_CONFIG_FILE="$FISH_CONFIG_DIR/config.fish"

# --- Packages ---
PACKAGES=(
    # System
    "pacman-contrib" "sed" "vim" "wget" "unzip" "zip" "tree" "bat" "ripgrep"
    "man-pages" "stow" "figlet" "jq" "fzf" "eza" "gum" "fish"

    # Networking & Bluetooth
    "networkmanager" "network-manager-applet" "nm-connection-editor"
    "bluez" "bluez-utils" "blueman"

    # Audio
    "pavucontrol"

    # GUI & Themes
    "alacritty" "dunst" "nitrogen" "papirus-icon-theme"
    "breeze-icons" "libnotify"

    # File & Media
    "thunar" "nautilus" "tumbler" "mousepad" "xarchiver"
    "thunar-archive-plugin" "mpv" "guvcview" "imagemagick"

    # Fonts
    "noto-fonts" "otf-font-awesome" "ttf-fira-sans"
    "ttf-fira-code" "ttf-jetbrains-mono-nerd"

    # Development
    "neovim" "python-pip" "python-psutil" "python-rich" "python-click"
    "python-pywal" "python-gobject" "python-dbus-next"
    "dotnet-sdk" "nodejs" "npm" "yarn"

    # WM & Extras
    "rofi" "picom" "qtile-extras" "fastfetch" "btop"

    # AUR / Extra tools
    "google-chrome" "etcher-bin" "postman-bin" "dbeaver"
    "telegram-desktop-bin"
    "ffmpeg" "lazydocker" "visual-studio-code-bin"
    # "mongodb-compass-bin"
)

DESKTOP_PACKAGES=(
    "fcitx5" "fcitx5-configtool" "fcitx5-qt"
    "fcitx5-gtk" "fcitx5-bamboo"
)

FISH_PLUGINS=(
    "gazorby/fish-abbreviation-tips"
    "jhillyerd/plugin-git"
    "jethrokuan/z"
    "jorgebucaran/autopair.fish"
)

# --- Helper Functions ---
log_info() { echo ">> $1"; }
log_success() { echo "✅ $1"; }
log_warning() { echo "⚠️ $1"; }
log_error() { echo "❌ $1"; }

is_installed() {
    pacman -Q "$1" &>/dev/null || yay -Q "$1" &>/dev/null
}

install_package() {
    if ! is_installed "$1"; then
        log_info "Installing $1..."
        yay -S --noconfirm "$1"
    else
        log_info "$1 is already installed, skipping."
    fi
}

set_default_shell() {
    if [[ "$(getent passwd "$USER" | cut -d: -f7)" != "$FISH_SHELL" ]]; then
        log_info "Changing default shell to fish..."
        sudo chsh -s "$FISH_SHELL" "$USER"
        log_success "Default shell changed to fish."
    else
        log_info "Default shell is already fish."
    fi
}

install_fisher() {
    if ! fish -c "type -q fisher"; then
        log_info "Installing Fisher..."
        fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
        log_success "Fisher installed."
    else
        log_info "Fisher is already installed."
    fi
}

install_fish_plugins() {
    for plugin in "${FISH_PLUGINS[@]}"; do
        if ! fish -c "fisher list | grep -q '$plugin'"; then
            log_info "Installing Fish plugin: $plugin"
            fish -c "fisher install $plugin"
        else
            log_info "Fish plugin '$plugin' already installed."
        fi
    done
}

configure_git() {
    log_info "Configuring Git..."
    git config --global user.name "$USER_NAME"
    git config --global user.email "$USER_EMAIL"

    if [ ! -f "$SSH_KEY_FILE" ]; then
        log_info "Generating SSH key..."
        mkdir -p "$(dirname "$SSH_KEY_FILE")"
        ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$SSH_KEY_FILE" -N ""
        log_success "SSH key generated."
    else
        log_info "SSH key already exists."
    fi
}

configure_fcitx5() {
    log_info "Setting up fcitx5..."
    for pkg in "${DESKTOP_PACKAGES[@]}"; do install_package "$pkg"; done

    mkdir -p "$FISH_CONFIG_DIR"

    env_vars=(
        "set -gx GTK_IM_MODULE fcitx5"
        "set -gx QT_IM_MODULE fcitx5"
        "set -gx XMODIFIERS \"@im=fcitx5\""
    )

    all_exist=true
    for var in "${env_vars[@]}"; do
        grep -q "$var" "$FISH_CONFIG_FILE" || all_exist=false
    done

    if ! $all_exist; then
        log_info "Adding fcitx5 environment variables to Fish config..."
        {
            echo "# fcitx5 environment variables"
            for var in "${env_vars[@]}"; do echo "$var"; done
        } >>"$FISH_CONFIG_FILE"
    else
        log_info "fcitx5 environment variables already configured."
    fi
}

configure_warp_client() {
    install_package "cloudflare-warp-bin"
    sudo systemctl enable --now warp-svc

    log_info "Registering with Cloudflare WARP..."
    warp-cli registration new

    log_info "Connecting to Cloudflare WARP..."
    warp-cli connect
    warp-cli dns families off
}

install_docker() {
    if is_installed "docker"; then
        log_info "Docker already installed."
        return
    fi

    log_info "Installing Docker..."
    sudo pacman -S --noconfirm docker docker-compose

    log_info "Starting and enabling Docker service..."
    sudo systemctl enable --now docker.service

    log_info "Adding user to docker group..."
    sudo usermod -aG docker "$USER"

    log_success "Docker installed. You may need to log out or run 'newgrp docker'."

    log_info "Running Docker test..."
    sudo docker run hello-world && log_success "Docker verified." || log_error "Docker test failed."
}
install_virt_manager() {
    sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs
    sudo systemctl enable --now libvirtd
    # sudo usermod -aG libvirt {user_name}
    sudo systemctl restart libvirtd
}
# --- Main Execution ---
log_info "🚀 Starting Arch Linux setup..."

if ! is_installed "yay"; then
    log_info "Installing yay..."
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm
    cd .. && rm -rf yay
    log_success "yay installed."
else
    log_info "yay is already installed."
fi

log_info "Setting timezone to $TIMEZONE..."
sudo timedatectl set-timezone "$TIMEZONE"

log_info "Updating system..."
sudo pacman -Syu --noconfirm

log_info "Installing packages..."
for pkg in "${PACKAGES[@]}"; do install_package "$pkg"; done

set_default_shell
install_fisher
install_fish_plugins
configure_git
configure_fcitx5
#configure_warp_client
install_docker
install_virt_manager

log_success "Arch Linux setup complete!"

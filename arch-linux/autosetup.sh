#!/bin/bash
#  _      ______ ____  __  __ _____ _   _
# | |    |  ____/ __ \|  \/  |_   _| \ | |
# | |    | |__ | |  | | \  / | | | |  \| |
# | |    |  __|| |  | | |\/| | | | | . ` |
# | |____| |___| |__| | |  | |_| |_| |\  |
# |______|______\____/|_|  |_|_____|_| \_|

set -euo pipefail

# --------------------------------------
# CONFIGURATION SECTION: Set up variables, timezone, user, and package lists
# --------------------------------------

TIMEZONE="Asia/Ho_Chi_Minh" # Timezone for your system

# List of essential packages to install (system, dev, terminal, GUI, fonts, etc.)
PACKAGES=(
  python python-pip tk python-virtualenv ffmpeg vim neovim stow bat fzf tree ripgrep tldr
  dotnet-sdk-8.0 dotnet-runtime-8.0
  kitty ghostty zoxide starship lazygit fastfetch visual-studio-code-bin mission-center discord
  mpv thorium-browser-bin brave-bin etcher-bin postman dbeaver yazi
  telegram-desktop lazydocker ttf-jetbrains-mono-nerd xclip docker qemu libvirt virt-manager gnome-keyring stremio
  dconf-editor telegram-desktop-bin
  # file manager cinnamon nemo
)

# --------------------------------------
# HELPER FUNCTIONS SECTION: Utility, logging, package management
# --------------------------------------

# Logging functions for info, success, warning, and error
log_info() { echo "[INFO] $1"; }
log_success() { echo "[OK]   $1"; }
log_warning() { echo "[WARN] $1"; }
log_error() { echo "[ERR]  $1"; }

# Check result of a command, exit if non-zero
check_result() {
  if [ "$1" -ne 0 ]; then
    log_error "$2"
    exit 1
  fi
}

# Check if a package is installed (pacman or yay)
is_installed() {
  pacman -Q "$1" &>/dev/null || yay -Q "$1" &>/dev/null
}

# Install a package if not already installed
install_package() {
  if ! is_installed "$1"; then
    log_info "Installing $1..."
    yay -S --noconfirm "$1"
  else
    log_info "$1 already installed. Skipping."
  fi
}

# --------------------------------------
# GIT AND SSH KEY CONFIGURATION
# Setup global Git user and email, generate SSH key if not exists
# --------------------------------------
configure_git_and_ssh() {
    SSH_KEY_FILE="$HOME/.ssh/id_ed25519"

    # Skip the entire function if SSH key already exists
    if [ -f "$SSH_KEY_FILE" ]; then
        echo "SSH key already exists at $SSH_KEY_FILE. Skipping Git and SSH configuration."
        return
    fi

    # Prompt for Git user.name and user.email
    read -rp "Enter your Git user.name: " USER_NAME
    read -rp "Enter your Git user.email: " USER_EMAIL

    # Configure Git
    git config --global user.name "$USER_NAME"
    git config --global user.email "$USER_EMAIL"

    # Generate SSH key
    echo "Generating SSH key at $SSH_KEY_FILE..."
    ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$SSH_KEY_FILE" -N ""

    # Add key to ssh-agent
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY_FILE"

    # Show public key
    echo "Your public SSH key:"
    cat "${SSH_KEY_FILE}.pub"
}


# --------------------------------------
# DOCKER INSTALLATION AND ENABLEMENT
# Install Docker and add current user to docker group
# --------------------------------------
config_docker() {
  # Enable and start docker service
  sudo systemctl enable docker.service

  # Make sure to add the executing user (not root if running sudo)
  local real_user="${SUDO_USER:-$USER}"
  sudo usermod -aG docker "$real_user"

  log_success "Docker installed. Please log out or run 'newgrp docker'."
}

# --------------------------------------
# FCITX5 VIETNAMESE INPUT METHOD SETUP
# Install fcitx5 and set environment variables for input methods
# --------------------------------------
configure_fcitx5() {
  log_info "Configuring fcitx5 (Vietnamese input method)..."
  local fcitx5_packages=(fcitx5 fcitx5-im fcitx5-qt fcitx5-gtk fcitx5-bamboo fcitx5-configtool)
  for pkg in "${fcitx5_packages[@]}"; do install_package "$pkg"; done

  echo "➡️  Please restart your graphical session or reboot for the changes to take effect."
}

# --------------------------------------
# DOWNLOAD WALLPAPER REPOSITORY FROM GITHUB
# --------------------------------------

clone_wallpaper() {
  log_info "Cloning wallpaper repository..."
  if [ ! -d "~/Pictures/wallpaper" ]; then # Check if directory exists before cloning
    cd ~/Pictures                          # You can also choose a different location
    git clone --depth=1 https://github.com/Leomin07/wallpaper.git ~/Pictures/wallpaper &&
      log_success "Wallpaper repository cloned to ~/Pictures/wallpaper." || log_error "Failed to clone wallpaper repository."
  else
    log_info "Wallpaper repository already exists in ~/Pictures/wallpaper, skipping clone."
  fi
}

# --------------------------------------
# NODEJS (NVM + YARN) INSTALLATION
# --------------------------------------
install_nodejs() {
  # Install NVM (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

  # Source NVM to make it available in the current shell session
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  # Install the latest LTS version of Node.js
  nvm install --lts

  # Install Yarn globally using npm
  npm install --global yarn
}

# --------------------------------------
# YES/NO PROMPT FUNCTION FOR USER CONFIRMATION
# --------------------------------------
ask_yes_no() {
  while true; do
    read -rp "$1 [y/n]: " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}

# --------------------------------------
# CLOUDFLARE WARP VPN INSTALLATION AND REGISTRATION
# --------------------------------------
install_warp_client() {
  log_info "Installing Cloudflare WARP client..."
  install_package "cloudflare-warp-bin"

  log_info "Ensuring Cloudflare WARP service (warp-svc) is running and enabled..."
  sudo systemctl enable --now warp-svc || {
    log_error "Failed to enable and start warp-svc. Please check systemd logs."
    return 1
  }

  log_info "Attempting to delete any existing Cloudflare WARP registration..."
  if sudo warp-cli registration delete; then
    log_success "Old Cloudflare WARP registration deleted."
  else
    log_info "No old Cloudflare WARP registration found, proceeding."
  fi

  log_info "Registering new Cloudflare WARP client..."
  if sudo warp-cli registration new; then
    log_success "Cloudflare WARP client registered successfully."
  else
    log_error "Failed to register Cloudflare WARP client."
    return 1
  fi

  log_info "Connecting Cloudflare WARP..."
  if sudo warp-cli connect; then
    log_success "Cloudflare WARP connected successfully."
  else
    log_error "Failed to connect Cloudflare WARP."
    return 1
  fi

  log_success "Cloudflare WARP setup complete and connected."
  log_info "You can check its status with: warp-cli status"
}

# --------------------------------------
# INSTALL AND CONFIGURE ZSH (Oh My Zsh + plugins)
# --------------------------------------
setup_zsh() {
  # 1. Install Zsh if not present
  if ! command -v zsh &>/dev/null; then
    log_info "Installing Zsh..."
    # sudo pacman -S --noconfirm zsh && log_success "Zsh installed." || {
    #     log_error "Failed to install Zsh."
    #     return 1
    # }
    install_package "zsh"
  else
    log_info "Zsh is already installed, skipping."
  fi

  # 2. Install Oh My Zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log_info "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &&
      log_success "Oh My Zsh installed." || {
      log_error "Failed to install Oh My Zsh."
      return 1
    }
  else
    log_info "Oh My Zsh is already installed, skipping."
  fi

  # 3. Set Zsh as default shell
  local real_user="${SUDO_USER:-$USER}"
  local current_shell
  current_shell="$(getent passwd "$real_user" | cut -d: -f7)"
  if [ "$current_shell" != "$(which zsh)" ]; then
    log_info "Changing default shell to Zsh for user $real_user..."
    sudo chsh -s "$(which zsh)" "$real_user" &&
      log_success "Default shell changed to Zsh (log out to apply)." ||
      log_error "Failed to change default shell to Zsh."
  else
    log_info "Default shell is already Zsh."
  fi

  # 4. Install recommended Zsh plugins
  local plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
  declare -A plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
  )
  for name in "${!plugins[@]}"; do
    local dir="$plugins_dir/$name"
    if [ ! -d "$dir" ]; then
      log_info "Installing Zsh plugin: $name..."
      git clone "${plugins[$name]}" "$dir" && log_success "Plugin '$name' installed." || log_error "Failed to install plugin '$name'."
    else
      log_info "Zsh plugin '$name' is already installed, skipping."
    fi
  done

  # 5. Update ~/.zshrc plugins section
  local zshrc="$HOME/.zshrc"
  local desired_plugins="plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions z docker docker-compose)"
  if grep -qE '^plugins=\(.*\)' "$zshrc"; then
    log_info "Updating plugins list in ~/.zshrc..."
    sed -i 's/^plugins=(.*)/'"$desired_plugins"'/' "$zshrc" &&
      log_success "Updated plugins in ~/.zshrc." ||
      log_error "Failed to update plugins in ~/.zshrc."
  else
    log_info "Adding plugins list to ~/.zshrc..."
    echo "$desired_plugins" >>"$zshrc" &&
      log_success "Added plugins to ~/.zshrc." ||
      log_error "Failed to add plugins to ~/.zshrc."
  fi

  # 6. Check and copy .zshrc file from dotfiles
  if [ -f "$HOME/.zshrc" ]; then
    log_info "Detected old ~/.zshrc, proceeding to delete..."
    rm "$HOME/.zshrc"
  fi
  if [ -f "$HOME/dotfiles/zshrc/.zshrc" ]; then
    # cp "$HOME/dotfiles/zshrc/.zshrc" "$HOME/"
    stow "zshrc" --target="$HOME" --dir="$HOME/dotfiles"
    log_success "Stow ~/dotfiles/zshrc/.zshrc to $HOME/.zshrc"
  else
    log_warning "~/dotfiles/zshrc/.zshrc not found, skipping copy step."
  fi

  log_warning "📌 Add the following plugins to your ~/.zshrc: plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions z docker docker-compose)"
}

# --------------------------------------
# AUTOSTART MAP-KEY TOOL ON LOGIN
# --------------------------------------
mapkey() {
  local DOTFILES_DIR="$HOME/dotfiles/arch-linux"
  local XMODMAP_SOURCE="$DOTFILES_DIR/.Xmodmap"
  local XMODMAP_TARGET="$HOME/.Xmodmap"
  local XPROFILE="$HOME/.xprofile"

  # Check if source .Xmodmap exists
  if [ ! -f "$XMODMAP_SOURCE" ]; then
    echo "❌ File not found: $XMODMAP_SOURCE"
    return 1
  fi

  # Symlink .Xmodmap to home directory
  echo "🔗 Linking $XMODMAP_SOURCE to $XMODMAP_TARGET ..."
  ln -sf "$XMODMAP_SOURCE" "$XMODMAP_TARGET"

  # Ensure ~/.xprofile loads .Xmodmap
  if ! grep -q 'xmodmap .*\.Xmodmap' "$XPROFILE" 2>/dev/null; then
    echo "➕ Adding xmodmap load to $XPROFILE"
    cat <<'EOF' >>"$XPROFILE"

# Load custom Xmodmap on X11 login
if [ -f "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi
EOF
  else
    echo "✅ ~/.xprofile already contains xmodmap load."
  fi

  # Apply immediately
  echo "⚡ Applying Xmodmap now..."
  xmodmap "$XMODMAP_TARGET"

  echo "✅ Done. The Insert key is now remapped to Home, and will persist after reboot/login."
}

config_gnome() {
  # Remove gnome apps
  local apps=(gnome-mines quadrapassel gnome-chess gnome-reversi gnome-characters gnome-logs gnome-music gnome-weather gnome-sound-recorder collision gnome-chess gnome-maps gnome-mines iagno gnome-tour gnome-weather gnome-clock gnome-connections gnome-contacts simple-scan yelp lollypop endeavour snapshot micro)
  for app in "${apps[@]}"; do
    sudo pacman -Rns --noconfirm "$app" && log_info "Removed $app"
  done

  # Install gnome-shell-extension-manager
  for pkg in "extension-manager"; do
    install_package "$pkg"
  done
  # Load gnome extensions
  dconf load /org/gnome/shell/extensions/ <~/dotfiles/arch-linux/dump_extensions_gnome.txt

  # Enable ghostty default terminal
  gsettings set org.gnome.desktop.default-applications.terminal exec 'ghostty'

  # Load custom shortcut cinnamon
  # dconf load /org/gnome/desktop/keybindings/ < ~/dotfiles/arch-linux/cinnamon_custom_keybindings.dconf

  echo "Success"
}

# --------------------------------------
# INSTALL VIRTUALIZATION SOFTWARE (QEMU, Virt-Manager, etc.)
# --------------------------------------
config_virt_manager() {
  sudo systemctl enable --now libvirtd
  sudo usermod -aG libvirt ${USER}
  sudo systemctl restart libvirtd
}

# Function to install ibus and ibus-bamboo on Arch Linux, and configure environment variables properly for .xprofile
install_ibus_bamboo() {
  echo "Installing ibus and ibus-bamboo..."
  local ibus_packages=(ibus ibus-bamboo)
  local ibus_file="$HOME/dotfiles/arch-linux/ibus.desktop"
  local autostart_dir="$HOME/.config/autostart"

  # Check file existence
  if [[ ! -f "$ibus_file" ]]; then
    echo "The file $desktop_file does not exist!"
    return 1
  fi

  cp "$ibus_file" "$autostart_dir"

  # Install packages if not already present
  for pkg in "${ibus_packages[@]}"; do
    install_package "$pkg"
  done

  # List of environment variables to set
  local env_vars=(
    'GTK_IM_MODULE=ibus'
    'QT_IM_MODULE=ibus'
    'XMODIFIERS="@im=ibus"'
  )

  # Helper function to add environment variable if not already present
  add_env_if_missing() {
    local file=$1
    local var_name
    for env in "${env_vars[@]}"; do
      var_name="${env%%=*}"
      # Remove any existing export of this variable before appending
      sed -i "/^\s*export\s\+$var_name=/d" "$file" 2>/dev/null
      echo "export $env" >>"$file"
      echo "Set export $env in $file"
    done
  }

  # Add to ~/.bashrc and source from ~/.bash_profile
  local BASH_FILE="$HOME/.bashrc"
  log_info "Checking Bash config: $BASH_FILE"
  add_env_if_missing "$BASH_FILE"
  local BASH_PROFILE="$HOME/.bash_profile"
  grep -q '[[ -f ~/.bashrc ]] && source ~/.bashrc' "$BASH_PROFILE" 2>/dev/null || echo '[[ -f ~/.bashrc ]] && source ~/.bashrc' >>"$BASH_PROFILE"

  # # Add to ~/.zshrc and source from ~/.zprofile
  # local ZSH_FILE="$HOME/.zshrc"
  # log_info "Checking Zsh config: $ZSH_FILE"
  # add_env_if_missing "$ZSH_FILE"
  # local ZSH_PROFILE="$HOME/.zprofile"
  # grep -q '[[ -f ~/.zshrc ]] && source ~/.zshrc' "$ZSH_PROFILE" 2>/dev/null || echo '[[ -f ~/.zshrc ]] && source ~/.zshrc' >>"$ZSH_PROFILE"

  echo "Installation and configuration complete!"
  echo "Please log out and log in again, then add 'Bamboo' in IBus Preferences if needed."
}

# Gnu stow config
stow_configs() {
  local folders=("ghostty" "kitty" "nvim")
  local config_dir="$HOME/.config"
  local dotfiles_dir="$HOME/dotfiles"

  # Ensure the dotfiles_dir exists
  if [ ! -d "$dotfiles_dir" ]; then
    log_error "Dotfiles directory '$dotfiles_dir' does not exist. Please create it first."
    return 1
  fi

  # Change into the dotfiles_dir so 'stow' can operate correctly
  # Use a subshell () to avoid changing the current directory of the calling shell
  (
    cd "$dotfiles_dir" || {
      log_error "Could not access directory $dotfiles_dir"
      return 1
    }

    local normalized_dotfiles_root
    normalized_dotfiles_root="$(readlink -f "$dotfiles_dir")"
    normalized_dotfiles_root="${normalized_dotfiles_root%/}" # Remove trailing slash if any

    for folder in "${folders[@]}"; do
      log_info "Processing package '$folder'..."

      # Full path to the package source directory within dotfiles (e.g., /home/minhtd/dotfiles/nvim)
      local package_source_dir="${normalized_dotfiles_root}/${folder}"

      # Check if the package source directory actually exists
      if [ ! -d "$package_source_dir" ]; then
        log_error "  Source package directory '$package_source_dir' does not exist. Skipping this package."
        continue
      fi

      # The path where the symlink is expected to appear (e.g., ~/.config/nvim)
      local target="$config_dir/$folder"

      # --- CALCULATE PRECISE expected_symlink_target ---
      # This is crucial to match your specific dotfile structure (e.g., dotfiles/package/.config/package)
      local expected_symlink_target=""

      # => relative_target_from_config = nvim
      local relative_target_from_config="${target#$config_dir/}"

      expected_symlink_target="${package_source_dir}/.config/${relative_target_from_config}"
      expected_symlink_target="${expected_symlink_target%/}" # Canonicalize: remove trailing slash if any

      # --- 1. If the target does NOT exist ---
      if [ ! -e "$target" ]; then
        log_info "  '$target' does not exist. Proceeding to stow '$folder'."
        stow "$folder" --target="$HOME" --dir="$dotfiles_dir"
        if [ $? -eq 0 ]; then
          log_success "  Successfully stowed '$folder' into '$config_dir'."
        else
          log_error "  Stow of '$folder' failed."
        fi
        continue # Move to the next package
      fi

      # --- 2. If the target IS a symlink AND points to the CORRECT source ---
      if [ -L "$target" ]; then # Check if it's a symbolic link
        local actual_link
        actual_link="$(readlink -f "$target")" # Get the absolute path the symlink points to
        actual_link="${actual_link%/}"         # Canonicalize: remove trailing slash if any

        if [ "$actual_link" = "$expected_symlink_target" ]; then
          log_info "  '$target' is already correctly symlinked to '$expected_symlink_target'. Skipping."
          continue # Move to the next package
        else
          log_info "  '$target' is an incorrect symlink (points to '$actual_link' instead of '$expected_symlink_target')."
        fi
      else
        # If -e is true but -L is false, it's a regular directory or file
        log_info "  '$target' exists but is not a symlink. Will move to .bak."
      fi

      # --- 3. If the target exists but is NOT a correct symlink (or is a wrong symlink) ---
      # (Execution reaches here if the above conditions were not met)
      local bak_name="${target}.bak"
      local i=1
      while [ -e "$bak_name" ]; do # Find a unique backup name
        bak_name="${target}.bak$i"
        ((i++))
      done

      log_info "  Moving '$target' to '$bak_name' to make way for new symlink."
      mv "$target" "$bak_name"
      if [ $? -ne 0 ]; then
        log_error "  Could not rename '$target' to '$bak_name'. Skipping stow for this package."
        continue
      fi

      # Finally, perform the stow operation
      log_info "  Proceeding to stow '$folder'."
      stow "$folder" --target="$HOME" --dir="$dotfiles_dir"
      if [ $? -eq 0 ]; then
        log_success "  Successfully stowed '$folder' into '$config_dir'."
      else
        log_error "  Stow of '$folder' failed."
      fi
    done
  )
}

# --------------------------------------
# MAIN EXECUTION SECTION: The actual installation steps and user prompts
# --------------------------------------

# Install yay if not available (AUR helper)
if ! is_installed "yay"; then
  log_info "Installing yay..."
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm && cd .. && rm -rf yay
fi

# Set timezone and update system packages
sudo timedatectl set-timezone "$TIMEZONE"
sudo pacman -Syu --noconfirm

# Install all base packages
for pkg in "${PACKAGES[@]}"; do install_package "$pkg"; done

# Install and configure Zsh & plugins
setup_zsh

# Install NodeJS (nvm, yarn)
install_nodejs

# Configure Git and SSH key
configure_git_and_ssh

# Config Docker
config_docker

# Stow config
stow_configs

# Optional setups with yes/no prompt for user customization
if ask_yes_no "Configure mapkey(X11)?"; then mapkey; fi
# if ask_yes_no "Configure gnome?"; then config_gnome; fi
if ask_yes_no "Install ibus-bamboo?"; then install_ibus_bamboo; fi
if ask_yes_no "Configure fcitx5 environment?"; then configure_fcitx5; fi
if ask_yes_no "Clone wallpaper repository?"; then clone_wallpaper; fi
if ask_yes_no "Install warp client?"; then install_warp_client; fi
if ask_yes_no "Install virt_manager?"; then config_virt_manager; fi

log_success "Arch Linux setup script completed!"

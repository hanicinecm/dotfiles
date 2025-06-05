#!/usr/bin/env bash

set -e  # Exit on any error
set -u  # Treat unset variables as errors
set -o pipefail  # Better error propagation in pipelines

DOTFILES_DIR="$HOME/.dotfiles"
LOGOUT_REQUIRED=0

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Error: DOTFILES_DIR '$DOTFILES_DIR' does not exist." >&2
    exit 1
fi


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Updating system packages  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

sudo apt update
sudo apt upgrade -y


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing apt packages  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

APT_PACKAGES=(stow zsh bat)
sudo apt install -y "${APT_PACKAGES[@]}"
echo "✅ APT packages installed: ${APT_PACKAGES[*]}"


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Symlinking the dotfiles  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

# Install GNU Stow, if not installed already
if ! command -v stow &> /dev/null; then
    sudo apt install -y stow
    echo "✅ stow installed."
fi

# TODO: Properly solve archiving the conflicting files
rm "$HOME/.bashrc" 2>/dev/null || true
rm "$HOME/.profile" 2>/dev/null || true

# Symlink the dotfiles using GNU Stow
stow -d "$DOTFILES_DIR" -t "$HOME" home
echo "✅ Dotfiles symlinked to $HOME."


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing oh-my-zsh  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

OMZ_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
OMZ_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZ_DIR" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL "$OMZ_URL")"
    echo "✅ oh-my-zsh installed."
else
    echo "ℹ️ oh-my-zsh is already installed."
fi


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing zsh plugins  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

ZSH_CUSTOM="${ZSH_CUSTOM:-$OMZ_DIR/custom}"

declare -A plugins=(
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

for plugin in "${!plugins[@]}"; do
    dest="${ZSH_CUSTOM}/plugins/${plugin}"
    repo="${plugins[$plugin]}"

    if [ -d "$dest" ]; then
        echo "ℹ️  $plugin already installed at $dest"
    else
        echo -e "\n🔌 Installing plugin: $plugin"
        git clone "$repo" "$dest"
        echo -e "\n✅ $plugin cloned to $dest"
    fi
done


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing oh-my-posh  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

if ! command -v oh-my-posh &> /dev/null; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
    echo "✅ oh-my-posh installed."
else
    echo "ℹ️ oh-my-posh is already installed."
fi


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Setting the default shell  ━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "✅ Default shell changed to zsh."
    LOGOUT_REQUIRED=1
else
    echo "ℹ️ Default shell is already zsh."
fi


echo -e "\n━━━━━━━━━━━━━━━━ ✅ Setup complete  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

if [ "$LOGOUT_REQUIRED" -eq 1 ]; then
    read "⚠️ Would you like to log out to activate the changes? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Logging out..."
        cinnamon-session-quit --logout --no-prompt
    else
        echo "Log out manually. Now!"

fi

# - Install `oh-my-posh`.
# - Install `uv`.
# - Install Brave browser and join the sync chain.
# - Install VS Code.
# - Install `ghostty` and set it up as the default terminal.
# - Install the `papirus-icon-theme` and activate it.

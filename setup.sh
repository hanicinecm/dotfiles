#!/usr/bin/env bash

set -e  # Exit on any error
set -u  # Treat unset variables as errors
set -o pipefail  # Better error propagation in pipelines

DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Error: DOTFILES_DIR '$DOTFILES_DIR' does not exist." >&2
    exit 1
fi

echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Updating system packages  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

sudo apt update
sudo apt upgrade -y


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Symlinking the dotfiles  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

# Install GNU Stow, if not installed already
if ! command -v stow &> /dev/null; then
    sudo apt install -y stow
    echo "✅ stow installed."
fi

# Symlink the dotfiles using GNU Stow
stow -d "$DOTFILES_DIR" -t "$HOME" home
echo "✅ Dotfiles symlinked to $HOME."


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing zsh  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
    echo "✅ zsh installed."
else
    echo "ℹ️ zsh is already installed."
fi


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing oh-my-zsh  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

OMZ_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
OMZ_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZ_DIR" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL "$OMZ_URL")"
    echo "✅ oh-my-zsh installed."
else
    echo "ℹ️ oh-my-zsh is already installed."
fi

# # Set zsh as default shell for current user
# if [ "$SHELL" != "$(which zsh)" ]; then
#     chsh -s "$(which zsh)"
#     echo "✅ Default shell changed to zsh. You may need to log out and back in."
# fi

# - Install `oh-my-zsh` with `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.
# - Install `oh-my-posh`.
# - Install `uv`.
# - Install `batcat` with `sudo apt install bat`.
# - Install Brave browser and join the sync chain.
# - Install VS Code.
# - Install `ghostty` and set it up as the default terminal.
# - Install the `papirus-icon-theme` and activate it.

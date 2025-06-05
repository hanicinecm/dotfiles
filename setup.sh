#!/usr/bin/env bash

set -e  # Exit on any error
set -u  # Treat unset variables as errors
set -o pipefail  # Better error propagation in pipelines


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Updating system packages ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

sudo apt update
sudo apt upgrade -y


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
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL "$OMZ_URL")"
    echo "✅ oh-my-zsh installed."
else
    echo "ℹ️ oh-my-zsh is already installed."
fi


# # Set zsh as default shell for current user
# if [ "$SHELL" != "$(which zsh)" ]; then
#     chsh -s "$(which zsh)"
#     echo "✅ Default shell changed to zsh. You may need to log out and back in."
# fi
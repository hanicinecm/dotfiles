#!/usr/bin/env bash

set -e  # Exit on any error
set -u  # Treat unset variables as errors
set -o pipefail  # Better error propagation in pipelines


echo "🔧 Installing zsh..."

# Check if zsh is already installed
if ! command -v zsh &> /dev/null; then
    sudo apt update
    sudo apt install -y zsh
    echo "✅ zsh installed."
else
    echo "ℹ️ zsh is already installed."
fi

# Set zsh as default shell for current user
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔄 Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "✅ Default shell changed to zsh. You may need to log out and back in."
else
    echo "ℹ️ zsh is already your default shell."
fi

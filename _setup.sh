#!/usr/bin/env bash

# TODO: Properly solve archiving the conflicting files before stowing them.
# TODO: Something is adding `. "$HOME/.local/bin/env"` to all the shell config files.
# TODO: The stow symlinks whole directories, rather than files - that's a problem.

set -e  # Exit on any error
set -u  # Treat unset variables as errors
set -o pipefail  # Better error propagation in pipelines

DOTFILES_DIR="$HOME/.dotfiles"
LOGOUT_REQUIRED=0


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing uv  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

if ! command -v uv &> /dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo "✅ uv installed."
else
    echo "ℹ️ uv is already installed."
fi


echo -e "\n━━━━━━━━━━━━━━━━ 🔧 Installing ghostty  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"

if ! command -v ghostty &> /dev/null; then
    curl -fsSL \
        https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh | bash
    echo "✅ ghostty installed."
else
    echo "ℹ️ ghostty is already installed."
fi


# - Install Brave browser and join the sync chain.
# - Install VS Code.
# - Install the `papirus-icon-theme` and activate it.
# - Nerd fonts required? Don't know, ghostty has them, don't know about code terminal.
# - What about the pinned apps?
# - Set the ghostty terminal as the default terminal emulator.

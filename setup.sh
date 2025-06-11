#!/usr/bin/env bash

# TODO: Install a Nerd Font and configure Ghostty and VSCode to use it.
# TODO: For some reason, the system dark mode is not recognized by apps.
# TODO: Add the system background to the dconf settings.

set -euo pipefail

# Define some global variables, accessible to all scripts sourced by this script
DOTFILES_DIR="$HOME/.dotfiles"


# Check if scripts directory exists and has scripts
SCRIPTS_DIR="$DOTFILES_DIR/scripts"
if [ ! -d "$SCRIPTS_DIR" ] || [ -z "$(ls -A "$SCRIPTS_DIR"/*.sh 2>/dev/null)" ]; then
    echo "❌ No setup scripts found in $SCRIPTS_DIR."
    exit 1
fi


# Start with the system update
echo "🔄 Updating system packages..."
sudo apt update
sudo apt upgrade -y


# Execute all the setup scripts one by one
for script in "$SCRIPTS_DIR"/*.sh; do

    echo ""
    echo "🧩 Running $(basename "$script")"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    source "$script"
    echo ""
    echo "✅ Finished $(basename "$script")"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

done


# Sync the base python environment
echo "🔄 Syncing Python environment..."
uv sync --project ~/.venvs/base


# Load the dconf settings
dconf load /org/cinnamon/ < "$DOTFILES_DIR/dconf/cinnamon-settings.dconf"


echo ""
echo "🎉 The setup executed successfully."


# Set the zsh as the default shell:
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "ℹ️ Changing the default shell to zsh."
    chsh -s "$(which zsh)"
    echo "🔔 Default shell has been changed. You have to log out and in again."
fi

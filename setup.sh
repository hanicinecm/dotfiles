#!/usr/bin/env bash

set -euo pipefail

# Define some global variables, accessible to all scripts sourced by this script
DOTFILES_DIR="$HOME/.dotfiles"
LOGOUT_REQUIRED=0  # Needs to be set to 1 by a script, if it requires a logout


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

echo ""
echo "🎉 All scripts executed successfully."

# Prompt the user to log out if required
echo "👍 Setup complete."
if [ "$LOGOUT_REQUIRED" -eq 1 ]; then
    echo "🔔 Some changes require you to log out and back in for them to take effect."
    echo "Please log out now."
fi


# TODO: Something is adding `. "$HOME/.local/bin/env"` to all the shell config files.
# TODO: The stow symlinks whole directories, rather than files - that's a problem.


# - Install Brave browser and join the sync chain.
# - Install VS Code.
# - Install the `papirus-icon-theme` and activate it.
# - Nerd fonts required? Don't know, ghostty has them, don't know about code terminal.
# - What about the pinned apps?
# - Add the dconf dump and load in from the script.

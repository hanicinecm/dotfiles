# This script will install the Papirus icon theme in the newest version.
# Instead of adding the PPA, the themes will be cloned from the GitHub repository
# and symlinked to the user's .icon directory.

# The Papirus icon theme:
if [ ! -d "$HOME/.icons/Papirus" ]; then
    # Clone the Papirus icon theme repository:
    echo "🔧 Cloning Papirus icon theme..."
    git clone --depth=1 https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git "$HOME/.themes/papirus-icon-theme"
    # Symlink the icons to the user's .icons directory:
    echo "🔗 Symlinking Papirus icons..."
    mkdir -p "$HOME/.icons"
    ln -sf "$HOME/.themes/papirus-icon-theme/Papirus" "$HOME/.icons/Papirus"
    ln -sf "$HOME/.themes/papirus-icon-theme/Papirus-Dark" "$HOME/.icons/Papirus-Dark"
    ln -sf "$HOME/.themes/papirus-icon-theme/Papirus-Light" "$HOME/.icons/Papirus-Light"
else
    echo "ℹ️ Papirus icon theme is already installed."
fi

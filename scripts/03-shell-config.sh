# This script installs the oh-my-zsh framework (with useful plugins) and the oh-my-posh
# theme engine.
# Both are already configured via the dotfiles symlinks.


# Check for dependencies:
for cmd in git curl; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "❌ $cmd is required but not installed."
        return 1
    fi
done


# Install oh-my-zsh:
OMZ_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
OMZ_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZ_DIR" ]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL "$OMZ_URL")"
    echo "✅ Installing oh-my-zsh framework."
fi


# Install the oh-my-zsh plugins:
ZSH_CUSTOM="${ZSH_CUSTOM:-$OMZ_DIR/custom}"

declare -A plugins=(
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

for plugin in "${!plugins[@]}"; do

    dest="${ZSH_CUSTOM}/plugins/${plugin}"
    repo="${plugins[$plugin]}"

    if [ -d "$dest" ]; then
        echo "ℹ️ $plugin already installed at $dest"
    else
        echo "🔌 Installing plugin: $plugin"
        git clone "$repo" "$dest"
        echo "✅ $plugin cloned to $dest"
    fi
done


# Install oh-my-posh:
if ! command -v oh-my-posh &> /dev/null; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
    echo "✅ Installing oh-my-posh theme engine."
fi


# Set the zsh as the default shell:
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "✅ Default shell changed to zsh."
    LOGOUT_REQUIRED=1
fi

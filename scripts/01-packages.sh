# This script installs all the essential packages, both from the official apt
# repository and from elsewhere.


# Install apt packages:
packages=(
    stow
    zsh
    bat
    curl
    # required by ghostty:
    libonig5
)
sudo apt install -y "${packages[@]}"


# The uv package manager:
if ! command -v uv &> /dev/null; then
    echo "🔧 Installing uv package manager..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "ℹ️ uv is already installed."
fi


# The ghostty terminal:
if ! command -v ghostty &> /dev/null; then
    echo "🔧 Installing ghostty terminal..."
    curl -LsSf \
        https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh | bash
else
    echo "ℹ️ ghostty is already installed."
fi

# This script installs all the essential packages, both from the official apt
# repository and from elsewhere.


# Add the Zettlr apt repository:
if ! grep -q zettlr /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    curl -s --compressed "https://apt.zettlr.com/KEY.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/zettlr_apt.gpg > /dev/null
    sudo curl -s --compressed -o /etc/apt/sources.list.d/zettlr.list "https://apt.zettlr.com/zettlr.list"
    sudo apt update
fi


# Install apt packages:
packages=(
    stow
    zsh
    bat
    curl
    libonig5
    inkscape
    zettlr
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


# The Brave browser:
if ! command -v brave-browser &> /dev/null; then
    echo "🔧 Installing Brave browser..."
    curl -fsS https://dl.brave.com/install.sh | sh
else
    echo "ℹ️ Brave browser is already installed."
fi

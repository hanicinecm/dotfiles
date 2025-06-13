# This script installs all the essential packages, both from the official apt
# repository and from elsewhere.

INSTALL_GHOSTTY=0
INSTALL_BRAVE=0
INSTALL_CODE=0


# Install apt packages:
packages=(
    stow
    zsh
    bat
    curl
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
if [[ "${INSTALL_GHOSTTY}" == "1" ]]; then
    if ! command -v ghostty &> /dev/null; then
        echo "🔧 Installing ghostty terminal..."
        curl -LsSf \
            https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh | bash
    else
        echo "ℹ️ ghostty is already installed."
    fi
fi


# The Brave browser:
if [[ "${INSTALL_BRAVE}" == "1" ]]; then
    if ! command -v brave-browser &> /dev/null; then
        echo "🔧 Installing Brave browser..."
        curl -fsS https://dl.brave.com/install.sh | sh
    else
        echo "ℹ️ Brave browser is already installed."
    fi
fi


# The VS Code editor:
if [[ "${INSTALL_CODE}" == "1" ]]; then
    if ! command -v code &> /dev/null; then
        sudo apt install wget gpg
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        rm -f packages.microsoft.gpg

        sudo apt install apt-transport-https
        sudo apt update
        sudo apt install code
    else
        echo "ℹ️ Visual Studio Code is already installed."
    fi
fi

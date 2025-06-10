# This script installs all the essential packages which are available in the
# official apt repositories.

packages=(
    stow
    zsh
    bat
    libonig5  # required by ghostty
)
sudo apt install -y "${packages[@]}"

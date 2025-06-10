# This script installs the Visual Studio Code editor and sets it up with the
# necessary extensions and settings.


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

# TODO: Install the extensions.
# TODO: Install the settings and configurations.

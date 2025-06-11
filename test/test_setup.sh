# A simple test script to verify that the setup.sh script has done its job.

#!/usr/bin/env bash
set -euo pipefail

# Colors for output
green="\033[0;32m"
red="\033[0;31m"
reset="\033[0m"

failures=0

SHELL_RC="$HOME/.zshrc"
source "$SHELL_RC"

function check() {
    "$@" && echo -e "${green}PASS${reset}: $*" || { echo -e "${red}FAIL${reset}: $*"; failures=$((failures+1)); }
}

# Check for installed packages
for pkg in zsh uv brave-browser code inkscape; do
    check command -v "$pkg"
done

# Check for oh-my-zsh and oh-my-posh
check test -d "$HOME/.oh-my-zsh"
check command -v oh-my-posh

# Check for symlinked dotfiles
for dot in .zshrc .bashrc .gitconfig; do
    check test -L "$HOME/$dot"
done

# Check that the 'act' alias works (activates base env)
check ! command -v python
check act && check which python

# Check that 'ipy' runs (should print IPython banner)
check ipy --version

if [[ $failures -eq 0 ]]; then
    echo -e "${green}All tests passed!${reset}"
    exit 0
else
    echo -e "${red}$failures test(s) failed.${reset}"
    exit 1
fi

# System Configuration

This is my personal system configuration, valid for Linux Mint.
It details the OS setup after a clean install.

## Initial Manual Setup

- Sort out the GitHub authentication.
- Clone the **dotfiles** repository to `~/.dotfiles`:
  - `git clone git@github.com:hanicinecm/dotfiles.git ~/.dotfiles`

## Dotfiles and Shell

- Install `zsh` and make it the default shell by `chsh -s $(which zsh)`.
- Install `oh-my-zsh` with `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.
- Install `oh-my-posh`.
- Install `stow`.
- Symlink the .dotfiles by `stow home` from `~/.dotfiles`.

## Other Software

- Install `uv`.
- Install `batcat` with `sudo apt install bat`.
- Install Brave browser and join the sync chain.
- Install VS Code.
- Install `ghostty` and set it up as the default terminal.
- Install the `papirus-icon-theme` and activate it.

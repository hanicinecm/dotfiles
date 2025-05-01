# System Configuration

This is my personal system configuration, valid for Linux Mint.
It details the OS setup after a clean install.

## Initial Setup
- Set up SSH authentication to GitHub by running `ssh-keygen` and adding the public
  key to the GitHub account.
- Install `git`.


## Dotfiles and Shell
- Install `zsh` and make it the default shell by `chsh -s $(which zsh)`.
- Install `oh-my-zsh` with `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.
- Install `oh-my-posh`.
- Install `uv`.
- Install `stow`.
- Clone the .dotfiles by `git@github.com:hanicinecm/dotfiles.git ~/.dotfiles`.
- Symlink the .dotfiles by `stow home` from `~/.dotfiles`.

## Other Software
- Install Brave browser and join the sync chain.
- Install VS Code.
- Install `ghostty` and set it up as the default terminal.

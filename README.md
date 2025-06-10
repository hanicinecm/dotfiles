# System Configuration

This is my personal system configuration, valid for Linux Mint Cinnamon.
It details the OS setup after a clean install.

## Initial Manual Setup

Sort out the GitHub authentication and clone the **dotfiles** repository to
`~/.dotfiles`:

```bash
git clone git@github.com:hanicinecm/dotfiles.git ~/.dotfiles
```

## Automated Setup

Execute the `setup.sh` script.

```bash
bash ~/.dotfiles/setup.sh
```

## Final Manual Setup

Some actions could not have been automized by the setup script:

- Set Brave as the default browser.
- Join the sync chain in Brave.
- Log in to VSCode and sync the settings.

## Documentation

This `setup.sh` script will take care of the following:

- Installation of various packages, such as `uv`, `ghostty`, `brave`, etc.
- Setting up `zsh` as the default shell and installation and configuration of
  `oh-my-zsh` frameworks (with plugins) and the `oh-my-posh` prompt.
- Safe symlinking of all the dotfiles from the `~/.dotfiles/home/` directory to `~`.
  This covers various configuration files (such as `.zshrc`, `.bashrc`, `.gitconfig`,
  etc.), as well as definition of the base python environment.
- Installation and setup of Visual Studio Code.
- Loading the Cinnamon `dconf` with various desktop settings, such as the themes,
  default terminal emulator, etc.

The script is *idempotent*, which means it can be executed on already set-up system
to achieve some partial setup only.

### Structure and Functionality

The `home/` directory in this repo mirrors the user home directory `~` on the system.
All the files in `home/` will be symlinked to the same relative paths inside `~` by the
`setup.sh` script.
Prior to the symlinking, the configuration files which already exist in the target `~`
directory (and which differ from the files in the source `home/` directory) will be
moved into a timestamped archive.

- TODO: Document the `scripts/` and `setup.sh`
- TODO: Document the base Python environment with the `act` and `ipy` commands

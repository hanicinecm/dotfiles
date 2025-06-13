# System Configuration

![OS](https://img.shields.io/badge/OS-Ubuntu-orange)
![OS](https://img.shields.io/badge/OS-Linux%20Mint-blue)
![CI](https://github.com/hanicinecm/dotfiles/actions/workflows/dotfiles-test.yml/badge.svg)

This is my personal system configuration, valid for Linux Mint Cinnamon
(or theoretically for any other Ubuntu-based distribution).

The repository contains various configuration files (dotfiles), as well as a setup
script, which installs all the dependencies and symlinks them to their place.

## Initial Manual Setup

Clone the __dotfiles__ repository to `~/.dotfiles`.

```shell
git clone https://github.com/hanicinecm/dotfiles.git ~/.dotfiles
```

Note, that the `~/.dotfiles` location is actually _mandatory_, as it is hard-coded in
the setup script.

## Automated Setup

Execute the `setup.sh` script.

```shell
bash ~/.dotfiles/setup.sh
```

## Final Manual Setup

Some actions could not be automized by the setup script:

- Configure the _Preferred Applications_:
  - Brave Browser for __Web__
  - Ghostty for __Terminal__
- Configure the _Themes_:
  - __Dark__ system theme
  - __Papirus__ icons
  - __Yaru__ mouse pointer
- Set Brave as the default browser (by running the browser for the first time and
  following the prompts).
- Join the sync chain in Brave.
- Log in to VS Code and sync the settings.
- Set up the SSH authentication to GitHub.

## Documentation

This `setup.sh` script will automatically do the following:

- Install various packages, such as `uv`, `ghostty`, `brave`, `code`, etc.
- Set up `zsh` as the default shell and install and configure the `oh-my-zsh` framework
  (with plugins) and the `oh-my-posh` prompt engine.
- Safely symlink of all the dotfiles from the `~/.dotfiles/home/` directory to `~`.
  This covers various configuration files (such as `.zshrc`, `.bashrc`, `.gitconfig`,
  etc.), as well as definition of the base python environment.

The script is _idempotent_, which means it can be executed on already set-up system
to achieve some partial setup only.

### Structure and Functionality

The `setup.sh` script will:

- Update all the system packages
- Execute all the shell scripts found in `scripts/` directory

The shell scripts will install bunch of packages, symlink all the dotfiles, and set up
the shell.

The `home/` directory in this repo mirrors the user home directory `~` on the system.
All the files in `home/` will be symlinked to the same relative paths inside `~` by the
`setup.sh` script.
Prior to the symlinking, the configuration files which already exist in the target `~`
directory (and which differ from the files in the source `home/` directory) will be
moved into a timestamped archive inside `~/.archived_dotfiles/`.

### Base Python Environment

Python environment is created by the `setup.sh` script.
The environment is implemented as a `uv` project called `base`, inside `~/.venvs/`.
The python version and the dependencies are controled by the
`home/.venv/base/pyproject.toml` file, symlinked to `~` directory.

Two related aliases are sourced from the dotfiles:

- `act`: This will activate the `base` environment.
- `ipy`: This will run `ipython` inside the `base` environment. The `ipy` command is
  not a simple alias, but rather a function, which can receive additional arguments.
  The additional arguments will be forwarded straight into the `uv run` command, which
  executes the `ipython`.
  As an example, `ipy --with pandas` will run IPython from the `base` environment
  with the additional `pandas` library installed temporarily, only for this call.

### Testing

The repository contains a simple integration test shell script, containing tests that
some selected functionality indeed works after the setup script is executed.

Additionally, a CI pipeline is impelemented as a GitHub Actions workflow, which

- Runs the setup script on a fresh latest Ubuntu machine.
- Checks if the integration test passes.
- Tests for idempotence.

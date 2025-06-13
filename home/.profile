# if we're running bash, lets just source the .bashrc
# if we're running zsh, it will get sourced even in the login shell

[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

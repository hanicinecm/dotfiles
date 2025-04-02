# This is the BASH configuration file

# Source common shell configuration
[[ -f "$HOME/.shellrc" ]] && source "$HOME/.shellrc"

# Activate oh-my-posh theme engine if available
if command -v oh-my-posh &>/dev/null && \
   [[ -f "$HOME/.config/oh-my-posh/config.yaml" ]]; then
    eval "$(oh-my-posh init bash --config \
        "$HOME/.config/oh-my-posh/config.yaml")"
fi

# Load uv autocompletion if available
if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion bash)"
    eval "$(uvx --generate-shell-completion bash)"
fi

# Aliases
alias ls="ls -CF --color=auto"
alias ll="ls -l"
alias l="ls -lA"

# This is the BASH configuration file

# Source common shell configuration
[[ -f "$HOME/.shellrc" ]] && source "$HOME/.shellrc"

# Activate oh-my-posh theme engine if available
if command -v oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh init bash --config "$HOME/.config/oh-my-posh/config.yaml")"
fi

# Load uv autocompletion if available
if command -v uv &>/dev/null; then
    eval "$(uv generate-shell-completion bash)"
    eval "$(uvx --generate-shell-completion bash)"
fi

# Source the common aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# This is the ZSH configuration file.

# Source common shell configuration
[[ -f "$HOME/.shellrc" ]] && source "$HOME/.shellrc"

# Zsh history settings
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS

# Oh-my-zsh
ZSH="$HOME/.oh-my-zsh"
plugins=(history copyfile zsh-autosuggestions zsh-syntax-highlighting)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Configure Zsh plugins
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Activate oh-my-posh theme engine if available
if command -v oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/config.yaml")"
    # eval "$(oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/negligible.yaml")"
    # eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/negligible.omp.json')"
fi

# Load uv autocompletion if available
if command -v uv &>/dev/null; then
    autoload -Uz compinit && compinit
    eval "$(uv generate-shell-completion zsh)"
    eval "$(uvx --generate-shell-completion zsh)"
fi

# Source the common aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# # ==============================================================================
# # Powerlevel10k Instant Prompt (Must stay at the top)
# # ==============================================================================
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
export PATH="$HOME/.local/bin:$PATH"

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# ==============================================================================
# Theme
# ==============================================================================
eval "$(starship init zsh)"

# ==============================================================================
# General Environment Settings
# ==============================================================================
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# ==============================================================================
# Custom Functions & Native Poetry Completion Setup
# ==============================================================================
# Ensure custom zsh functions directory exists for standalone completions
fpath=(${ZDOTDIR:-$HOME}/.zfunc $fpath)

# Generate Poetry autocompletion natively if not already cached
if command -v poetry &>/dev/null; then
  [[ -d ${ZDOTDIR:-$HOME}/.zfunc ]] || mkdir -p ${ZDOTDIR:-$HOME}/.zfunc
  if [[ ! -f ${ZDOTDIR:-$HOME}/.zfunc/_poetry ]]; then
    poetry completions zsh > ${ZDOTDIR:-$HOME}/.zfunc/_poetry
  fi
fi

# ==============================================================================
# Zsh Completion Engine Setup
# ==============================================================================
autoload -Uz compinit
# Cache compinit for faster shell startup (check once every 24h)
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# ==============================================================================
# Antidote Plugin Manager
# ==============================================================================
ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"

if [[ -f "$ANTIDOTE_DIR/antidote.zsh" ]]; then
  source "$ANTIDOTE_DIR/antidote.zsh"

  # Static compilation for instant shell startup
  zsh_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins.zsh"
  zsh_plugins_txt="${ZDOTDIR:-$HOME}/.zsh_plugins.txt"

  if [[ ! -s "$zsh_plugins" || "$zsh_plugins_txt" -nt "$zsh_plugins" ]]; then
    antidote bundle < "$zsh_plugins_txt" > "$zsh_plugins"
  fi
  source "$zsh_plugins"
fi

# ==============================================================================
# fzf-tab & Completion Styling
# ==============================================================================
# Case-insensitive / hyphen-insensitive completion matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# Set descriptions format to enable group headers
zstyle ':completion:*:descriptions' format '[%d]'

# Preview directory contents with eza when tab-completing `cd` or path
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Preview file contents or directory contents for generic commands
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'if [[ -d $realpath ]]; then eza -1 --color=always $realpath; else head -50 $realpath 2>/dev/null; fi'

# Switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# ==============================================================================
# Autosuggestions Settings
# ==============================================================================
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ==============================================================================
# Shell Enhancements & Integrations
# ==============================================================================
# fzf search and navigation bindings (Ctrl+R, Ctrl+T, Alt+C)
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# ==============================================================================
# Runtime & Version Managers (pyenv, nvm)
# ==============================================================================

# ==============================================================================
# Other redirections
# ==============================================================================
eval "$(zoxide init zsh --cmd cd)"

# ==============================================================================
# Aliases
# ==============================================================================
alias ls="eza --icons=always --tree -L=2 --git"
alias ll="ls -al"
alias .="cd .."
alias ..="cd -"
alias nv="nvim ."

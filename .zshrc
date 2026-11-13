# ==============================================================================
# Powerlevel10k Instant Prompt (Must stay at the top)
# ==============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

### MODIFIED BY ARK8KOR BEGIN ###
 
# Kerberos token check in right aligned ZSH prompt
__krb_status() {
  if ! klist -s ; then
    print -n "(No Kerberos token -> run kinit)"
  fi
}
prompt_krb() {
  RPROMPT="%{%k%b%F{red}%}$(__krb_status)%f"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_krb

# ==============================================================================
# Runtime & Version Managers (pyenv, nvm)
# ==============================================================================
# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT/bin" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init - zsh)"
  eval "$(pyenv virtualenv-init -)"
fi

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# export environment variables
export PATH="$PATH:/home/ark8kor/.local/bin"
export PATH="$PATH:/home/ark8kor/Softwares/Editors/nvim-linux-x86_64/bin"
export PATH="$PATH:/home/ark8kor/Softwares/hugo-v0.150"
export PATH="$PATH:/opt/Compilers/arc-gcc/arc_gnu_2022.09_prebuilt_elf32_le_linux_install/bin"
export PATH="$PATH:/opt/Compilers/arm-gcc/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin"
export PATH="$PATH:/home/ark8kor/Workspace/Projects/BST-BSTS-Core/bst_ai_integration/src/bst_ai_integration/tools/COINES/0.5.1/PC/bin/x86/"

### MODIFIED BY ARK8KOR END ###

# ==============================================================================
# Aliases
# ==============================================================================
alias ls="eza --icons=always"
alias nv="nvim ."

# =============================================================================
# 1. ENVIRONMENT VARIABLES
# =============================================================================
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"

# =============================================================================
# 2. ZINIT INITIALIZATION
# =============================================================================
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZINIT%F{220} Compatible version...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f" || \
        print -P "%F{160} The clone has failed.%f"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# =============================================================================
# 3. PROMPT THEME: STARSHIP
# =============================================================================
eval "$(starship init zsh)"

# =============================================================================
# 4. PLUGIN MANAGEMENT
# =============================================================================
# Core Plugins
zinit wait lucid for \
 atinit"zicompinit; zicdreplay" \
    zsh-users/zsh-completions \
 atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-history-substring-search \
    hlissner/zsh-autopair \
    agkozak/zsh-z

# Syntax Highlighting (Must load last)
zinit wait lucid atinit"zicompinit; zicdreplay" for \
    zsh-users/zsh-syntax-highlighting

# =============================================================================
# 5. COMPLETION MENU STYLING
# =============================================================================
# Load colors and setup completion styles
autoload -U colors && colors

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# =============================================================================
# 6. FZF INTEGRATION
# =============================================================================
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# Dracula theme for fzf & better layout
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border=rounded \
--info=inline --prompt='∼ ' --pointer='▶' --marker='✓' \
--color=bg+:#282a36,bg:#1e1f29,spinner:#bd93f9,hl:#ff79c6 \
--color=fg:#f8f8f2,header:#ff79c6,info:#ffb86c,pointer:#ff79c6 \
--color=marker:#ff79c6,fg+:#f8f8f2,prompt:#50fa7b,hl+:#ff79c6"

# =============================================================================
# 7. HISTORY & SETTINGS
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt AUTOCD
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

# =============================================================================
# 8. KEYBINDINGS
# =============================================================================
bindkey -e
bindkey '^[[1;5C' forward-word          # Ctrl+Right
bindkey '^[[1;5D' backward-word         # Ctrl+Left
bindkey '^H' backward-kill-word         # Ctrl+Backspace
bindkey '^[[3;5~' kill-word             # Ctrl+Delete

# History Search Substring (Up/Down arrows)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =============================================================================
# 9. ALIASES
# =============================================================================
# Modern alternatives
if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza --icons -la --group-directories-first --git'
    alias tree='eza --tree --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -la --color=auto'
fi

if command -v bat &> /dev/null; then
    alias cat='bat --style=plain'
    alias catt='bat --style=numbers,changes'
fi

# Core commands
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias c='clear'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Reload config
alias zshconfig="$EDITOR ~/.zshrc"
alias sourcezsh="source ~/.zshrc"

# =============================================================================
# 10. CONDA INITIALIZATION
# =============================================================================
__conda_setup="$('/home/nuke/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nuke/miniconda3/etc/profile.d/conda.sh" ]; then
# . "/home/nuke/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
        export PATH="/home/nuke/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/tmp/_MEIq2w0sJ/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/tmp/_MEIq2w0sJ/etc/profile.d/conda.sh" ]; then
        . "/tmp/_MEIq2w0sJ/etc/profile.d/conda.sh"
    else
        export PATH="/tmp/_MEIq2w0sJ/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#!/usr/bin/env zsh

# General Options
# ------------------------------------------------------------------------------
## List jobs in the long format by default.
setopt LONG_LIST_JOBS

## Disable flow control and hence restore the ability to use C-s and C-q
setopt NO_FLOW_CONTROL

# Set Up Line Editor
# ------------------------------------------------------------------------------
## Enable vi mode
bindkey -v

## Bind Meta-. to insert last word of previous command and stay in insert mode
bindkey -M viins "\e." insert-last-word

## Bind C-R to search backwards in all modes
bindkey '^R' history-incremental-search-backward

## Bind C-S to search forward in all modes
bindkey '^S' history-incremental-search-forward

## History expansion on space 
bindkey ' ' magic-space

## Bind history navigation to C-P and C-N in all modes
bindkey '^P' up-line-or-history

## Bind history navigation to C-P and C-N in all modes
bindkey '^N' down-line-or-history

## Bind C-D to forward delete next char
bindkey '^D' delete-char

## Additionaly set up basic Emacs-style navigation
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char

# Set Up Command History
# ------------------------------------------------------------------------------
## Enable globally shared history (same history in every shell)
setopt SHARE_HISTORY

## When writing out the history file, older duplicate commands are omitted
setopt HIST_SAVE_NO_DUPS

## Don't save commands prefixed with at least one space to history
setopt HIST_IGNORE_SPACE

## Don't directly execute commands when using history expansion
setopt HIST_VERIFY

## Max number of history lines in memory
HISTSIZE=25000

# Set up history file
HISTFILE="$XDG_DATA_HOME/zsh/history"

## Max number of history lines saved in history file
SAVEHIST=200000

# Set Up Completion
# ------------------------------------------------------------------------------
# Problems with insecure directories under macOS?
# -> see https://stackoverflow.com/a/13785716/149220 for a solution
cache_directory="$XDG_CACHE_HOME/zsh"

## Use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$cache_directory/completion-cache"

## These were created by `compinstall`
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename "$ZDOTDIR/.zshrc"

## Initialize completion system
### Set location for compinit's dumpfile.
autoload -Uz compinit && compinit -d "$cache_directory/compinit-dumpfile"

# Set Up Plugins
# ------------------------------------------------------------------------------
source "$ZDOTDIR/plugin_helper.zsh"
plugins=( zsh-users/zsh-syntax-highlighting zsh-users/zsh-autosuggestions )
__init_plugins "${plugins[@]}"

# Starship
# ------------------------------------------------------------------------------
eval "$(starship init zsh)"

# Git and LazyGit
# ------------------------------------------------------------------------------
## Aliases
alias gst="git status"
alias gci="git commit"
alias gp="git push"
alias gfa="git fetch --all"
alias lg="lazygit"

# Homebrew (brew.sh)
# ------------------------------------------------------------------------------
if [[ -e "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

## Brew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit -d "$cache_directory/compinit-dumpfile"
fi

# fzf
# ------------------------------------------------------------------------------
eval "$(fzf --zsh)"

# zoxide (better `cd`)
# ------------------------------------------------------------------------------
eval "$(zoxide init zsh --cmd cd)"

# eza (better `ls`)
# ------------------------------------------------------------------------------
alias l="eza --icons"
alias ls="eza --icons"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lTg --icons"
alias lt1="eza -lTg --level=1 --icons"
alias lt2="eza -lTg --level=2 --icons"
alias lt3="eza -lTg --level=3 --icons"
alias lta="eza -lTag --icons"
alias lta1="eza -lTag --level=1 --icons"
alias lta2="eza -lTag --level=2 --icons"
alias lta3="eza -lTag --level=3 --icons"

# Other aliases
# ------------------------------------------------------------------------------
alias vim="nvim"
alias vi="nvim"
alias n="nvim"


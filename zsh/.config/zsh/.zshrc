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

## Enable edit-command-line widget for vi mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M viins '^Xe' edit-command-line

## Lower mode switching delay to 10ms
KEYTIMEOUT=1

## History expansion on space
bindkey ' ' magic-space

## Enable some basic Emacs-style navigation
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

## Remove binding for ^g (defaults to sending SIGINT) and call
## tmux-session-switcher instead
bindkey -r '^G'
bindkey -s '^G ' 'tmux-session-switcher\n'

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
if [[ ! -d "$XDG_DATA_HOME/zsh" ]]; then
  mkdir -p "$XDG_DATA_HOME/zsh"
fi
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

# Homebrew (brew.sh) completions
# ------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit -d "$cache_directory/compinit-dumpfile"
  else
    echo ERROR: Could not load brew completions.
  fi
fi

# mise-en-place
# ------------------------------------------------------------------------------
if type mise &>/dev/null; then
  eval "$(mise completion zsh)"
else
  echo ERROR: Could not evaluate mise completions
fi

# Set Up Plugins
# ------------------------------------------------------------------------------
source "$ZDOTDIR/plugin_helper.zsh"
plugins=(
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  Aloxaf/fzf-tab
  jeffreytse/zsh-vi-mode
)
__init_plugins "${plugins[@]}"

## Things to set up AFTER zsh-vi-mode has been initialized
zvm_after_init_commands+=(
  fzf_init
)

# Starship
# ------------------------------------------------------------------------------
if type starship &>/dev/null; then
  eval "$(starship init zsh)"
  eval "$(starship completions zsh)"
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
else
  echo ERROR: Could not load starship.
fi

# fzf
# ------------------------------------------------------------------------------
## fzf setup inside this function to append it to zvm_after_init_commands
function fzf_init() {
  if type fzf &>/dev/null; then
    source <(fzf --zsh)

    export FZF_CTRL_R_OPTS="
    --color header:italic
    --height=80%
    --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
    --header 'CTRL-Y: Copy command into clipboard, CTRL-/: Toggle line wrapping, CTRL-R: Toggle sorting by relevance'
    "

    export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --height=80%
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --header 'CTRL-/: Toggle preview window position'
    "

    export FZF_ALT_C_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'tree -C {}'
    --height=80%
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
    --header 'CTRL-/: Toggle preview window position'
    "
  else
    echo ERROR: Could not fzf shell integration.
  fi
}

# zoxide (better `cd`)
# ------------------------------------------------------------------------------
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
else
  echo ERROR: Could not load zoxide shell integration.
fi

# eza (better `ls`)
# ------------------------------------------------------------------------------
if type eza &>/dev/null; then
  alias l="eza --icons=always"
  alias la="eza -a --icons=always"
  alias lh="eza -ad --icons=always .*"
  alias ll="eza -lg --icons=always"
  alias lla="eza -lag --icons=always"
  alias llh="eza -lagd --icons=always .*"
  alias ls="eza --icons=always"
  alias lt2="eza -lTg --level=2 --icons=always"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lt4="eza -lTg --level=4 --icons=always"
  alias lt="eza -lTg --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
  alias lta4="eza -lTag --level=4 --icons=always"
  alias lta="eza -lTag --icons=always"
else
  echo ERROR: eza could not be found. Skip setting up eza aliases.
fi

# Git
# ------------------------------------------------------------------------------
## Aliases
alias gs="git status"
alias gc="git commit"
alias gd="git diff"
alias gds="git diff --staged"
alias gp="git pull"
alias gP="git push"
alias gfa="git fetch --all"
alias gol="git log --pretty=oneline"
alias golg="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias golga="git log --graph --decorate --pretty=oneline --abbrev-commit --all"
alias gsubinit="git submodule update --init --recursive && git submodule foreach --recursive 'git checkout main || git checkout master'"
alias gsubupdate="git submodule foreach --recursive 'git fetch && (git checkout main || git checkout master) && git pull'"

# LazyGit
# ------------------------------------------------------------------------------
alias lg="lazygit"

# Docker
# ------------------------------------------------------------------------------
if type docker &>/dev/null; then
  eval "$(docker completion zsh)"
else
  echo ERROR: eza could not be found. Skip setting up docker completion
fi

# Other aliases
# ------------------------------------------------------------------------------
alias n="nvim"
alias k="kubectl"
alias kg="kubectl get"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kd="kubectl describe"
alias ksc="kubectl config use-context"

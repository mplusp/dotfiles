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
bindkey -M vicmd '^X^E' edit-command-line
bindkey -M viins '^X^E' edit-command-line

## Lower mode switching delay to 10ms
KEYTIMEOUT=1

## Change cursor shape depending on active vi mode
## Cursor shape control sequences are defind in
## [XTerm Control Sequences](https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h4-Functions-using-CSI-_-ordered-by-the-final-character-lparen-s-rparen:CSI-Ps-SP-q.1D81)
## Inspired by:
## - https://unix.stackexchange.com/questions/547/make-my-zsh-prompt-show-mode-in-vi-mode/327572#327572
## - https://web.archive.org/web/20240411231013/https://dougblack.io/words/zsh-vi-mode.html
function zle-line-init zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]]; then
  # steady block cursor in cmd mode
  echo -ne '\e[2 q'
else
  # steady bar cursor in other modes
  echo -ne '\e[6 q'
fi
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

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

# Set Up Plugins
# ------------------------------------------------------------------------------
source "$ZDOTDIR/plugin_helper.zsh"
plugins=(
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  Aloxaf/fzf-tab
)
__init_plugins "${plugins[@]}"

# Homebrew (brew.sh)
# ------------------------------------------------------------------------------
if [[ -e "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo ERROR: Could not find brew. Skip setting up brew shellenv.
fi

## Brew completions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
else
  echo ERROR: Could not load brew completions.
fi

# Starship
# ------------------------------------------------------------------------------
if type starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  echo ERROR: Could not load starship.
fi

# Git and LazyGit
# ------------------------------------------------------------------------------
## Aliases
alias gst="git status"
alias gci="git commit"
alias gp="git push"
alias gfa="git fetch --all"
alias lg="lazygit"

# fzf
# ------------------------------------------------------------------------------
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
  alias ls="eza --icons=always"
  alias ll="eza -lg --icons=always"
  alias la="eza -lag --icons=always"
  alias lt="eza -lTg --icons=always"
  alias lt2="eza -lTg --level=2 --icons=always"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lt4="eza -lTg --level=4 --icons=always"
  alias lta="eza -lTag --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
  alias lta4="eza -lTag --level=4 --icons=always"
else
  echo ERROR: eza could not be found. Skip setting up eza aliases.
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


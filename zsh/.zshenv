#!/usr/bin/env zsh
# ~/.zshenv: Zsh environment file. Gets loaded for every kind of shell session.
# ------------------------------------------------------------------------------

# Zsh startup file execution order:
# ------------------------------------------------------------------------------
# For ALL zsh invocations:
# 1. /etc/zshenv (system-wide, always)
# 2. ~/.zshenv (user, always)
#
# For LOGIN shells only:
# 3. /etc/zprofile (system-wide, login shells only)
# 4. ~/.zprofile (user, login shells only)
#
# For INTERACTIVE shells only:
# 5. /etc/zshrc (system-wide, interactive shells)
# 6. ~/.zshrc (user, interactive shells)
#
# For LOGIN shells only (again):
# 7. /etc/zlogin (system-wide, login shells)
# 8. ~/.zlogin (user, login shells)
#
# Notes:
# - Replace ~/.* with $ZDOTDIR/.* if ZDOTDIR is set
# - Files 2-8 can be disabled by unsetting RCS or GLOBAL_RCS options

# Set up relevant XDG base directories.
# Spec: https://specifications.freedesktop.org/basedir-spec/latest/index.html
# ------------------------------------------------------------------------------
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Make sure directories actually exist
xdg_base_dirs=("$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME")
for dir in "${xdg_base_dirs[@]}"; do
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
  fi
done

# Set ZDOTDIR here. All other Zsh related configuration happens there.
# ------------------------------------------------------------------------------
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Make sure directories actually exist
if [[ ! -d "$ZDOTDIR" ]]; then
  mkdir -p "$ZDOTDIR"
fi

# Set up default editor
# ------------------------------------------------------------------------------
export EDITOR=nvim
export VISUAL=nvim

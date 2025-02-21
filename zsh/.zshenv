#!/usr/bin/env zsh
# .zshenv: Zsh environment file. Gets is loaded for every kind of shell session.
# ------------------------------------------------------------------------------

# Set up relevant XDG base directories.
# Spec: https://specifications.freedesktop.org/basedir-spec/latest/index.html
# ------------------------------------------------------------------------------
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

## Make sure directories actually exist
xdg_base_dirs=("$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME")
for dir in "${xdg_base_dirs[@]}"; do
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
  fi
done

## Add dir for user specific executables (recommended in above spec) to $PATH
user_specific_exe_dir="$HOME/.local/bin"
if [[ ! -d "$user_specific_exe_dir" ]]; then
  mkdir -p "$user_specific_exe_dir"
fi
export PATH="$user_specific_exe_dir:$PATH"

# Set $ZTODDIR here. All other Zsh related configuration happens there.
# ------------------------------------------------------------------------------
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Set up default editor
# ------------------------------------------------------------------------------
export EDITOR=nvim
export VISUAL=nvim


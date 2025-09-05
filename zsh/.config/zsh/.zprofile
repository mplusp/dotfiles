#!/usr/bin/env zsh
# $ZDOTDIR/.zprofile: Gets loaded for login shells.
# ------------------------------------------------------------------------------

# PATH extensions
# ------------------------------------------------------------------------------
# PATH is extended here in ~/.zprofile instead of ~/.zshenv (the more "correct"
# place) because sometimes /etc/zprofile exports PATH, overriding modifications
# made in ~/.zshenv. ~/.zprofile runs after /etc/zprofile. This ensures user
# PATH additions are available in all login shells.

# Add dir for user specific executables (recommended in XDG spec) to PATH
# Spec: https://specifications.freedesktop.org/basedir-spec/latest/index.html
# ------------------------------------------------------------------------------
# Make sure directories actually exist
user_specific_exe_dir="$HOME/.local/bin"
if [[ ! -d "$user_specific_exe_dir" ]]; then
  mkdir -p "$user_specific_exe_dir"
fi
export PATH="$user_specific_exe_dir:$PATH"

# cargo
# ------------------------------------------------------------------------------
export PATH="$PATH:$HOME/.cargo/bin"

# Rancher Desktop
# ------------------------------------------------------------------------------
export PATH="$PATH:$HOME/.rd/bin"

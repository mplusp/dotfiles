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

# Homebrew (brew.sh)
# ------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -e "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo ERROR: Could not find brew. Skip setting up brew shellenv.
  fi
fi

# mise-en-place
# ------------------------------------------------------------------------------
if type mise &>/dev/null; then
  eval "$(mise activate zsh)"
else
  echo ERROR: Could not activate mise.
fi

# bob
# ------------------------------------------------------------------------------
if [[ -e "$XDG_DATA_HOME/bob/env/env.sh" ]]; then
  source "$XDG_DATA_HOME/bob/env/env.sh"
else
  echo "ERROR: Could not source $XDG_DATA_HOME/bob/env/env.sh"
fi

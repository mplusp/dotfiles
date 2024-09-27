#!/usr/bin/env zsh

# My little ZSH plugin helper
# ------------------------------------------------------------------------------
## Load this module to ensure $EPOCHSECONDS is available
zmodload zsh/datetime

local enable_plugin_helper_messages=false
local plugins_dir="$XDG_STATE_HOME/zsh/plugins"

function __init_plugins() {
  local plugins=("$@")
  for plugin in "${plugins[@]}"; do
    if [[ ! -d "$plugins_dir/$plugin" ]]; then
      __install_plugin "$plugin"
    fi
    if [[ -d "$plugins_dir/$plugin" ]]; then
      __update_plugin_if_stale "$plugin"
    fi
    if [[ -d "$plugins_dir/$plugin" ]]; then
      __load_plugin "$plugin"
    fi
  done
}

local function __update_plugin_if_stale() {
  local plugin="$1"
  local one_day_in_seconds=$(( 60 * 60 * 24 ))
  local last_update_file="$plugins_dir/$plugin"_last_update
  local last_update_timestamp=""

  if [[ -e "$last_update_file" ]]; then
    last_update_timestamp="$(cat $last_update_file)"
  fi

  # update even if no timestamp is found
  if [[ -z "$last_update_timestamp" ]]; then
    __update_plugin "$plugin"
    return
  fi
    local time_difference=$(( "$EPOCHSECONDS" - "$last_update_timestamp" ))
    if [[ $time_difference -ge $one_day_in_seconds ]]; then
      __update_plugin "$plugin"
    fi
}

local function __install_plugin() {
  local plugin="$1"
  local plugin_dir="$plugins_dir/$plugin"
  local last_update_file="$plugins_dir/$plugin"_last_update

  if [[ -d "$plugin_dir" ]]; then
    echo "Installation of '$plugin' aborted, because plugin directory already exists."
    return 1
  fi

  if $enable_plugin_helper_messages; then
    echo "Installing '$plugin' into '$plugin_dir'..."
    git clone "https://github.com/$plugin.git" "$plugin_dir"
  else
    git clone "https://github.com/$plugin.git" "$plugin_dir" 1&>/dev/null
  fi
  echo "$EPOCHSECONDS" > "$last_update_file"
}

local function __update_plugin() {
  local plugin="$1"
  local plugin_dir="$plugins_dir/$plugin"
  local last_update_file="$plugins_dir/$plugin"_last_update

  if [[ ! -d "$plugin_dir" ]]; then
    echo "Update aborted, because plugin '$plugin' could not be found."
    return 1
  fi

  if $enable_plugin_helper_messages; then
    echo "Updating '$plugin'..."
    git --git-dir="$plugin_dir/.git" pull --no-rebase
  else
    git --git-dir="$plugin_dir/.git" pull --no-rebase 1&>/dev/null
  fi
  echo "$EPOCHSECONDS" > "$last_update_file"
}

local function __load_plugin() {
  local plugin="$1"
  local plugin_dir="$plugins_dir/$plugin"

  if [[ ! -d "$plugin_dir" ]]; then
    echo "Loading of plugin '$plugin' aborted, because it could not be found."
    return 1
  fi

  if $enable_plugin_helper_messages; then
    echo "Loading '$plugin'..."
  fi
  source "$plugin_dir/$(basename $plugin).zsh"
}


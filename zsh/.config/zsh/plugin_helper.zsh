#!/usr/bin/env zsh

# My little ZSH plugin helper
# ------------------------------------------------------------------------------
plugin_path="$XDG_STATE_HOME/zsh/plugins"

function _init_plugins() {
  plugins=("$@")
  for plugin in "${plugins[@]}"; do
    if [[ ! -d "$plugin_path"/"$plugin" ]]; then
      __install_plugin "$plugin"
    fi
    if [[ -d "$plugin_path"/"$plugin" ]]; then
      # __update_if_last_update_was_more_than_a_day_ago "$plugin"
      __update_plugin "$plugin"
    fi
    if [[ -d "$plugin_path"/"$plugin" ]]; then
      __load_plugin "$plugin"
    fi
  done
}

## TODO: Fix this for macOS
## This works fine on Linux with GNU date.
## The macOS version of date does work differently, though.
## For now, we just update every time we open a shell.
# local function __update_if_last_update_was_more_than_a_day_ago() {
#   local plugin="$1"
#   local last_update_file="$plugin_path"/"$plugin"_last_update
#   local one_day_in_seconds=$(( 60 * 60 * 24 ))
#   local last_update_time=$(date -r "$last_update_file" +"%s")
#   local now=$(date +"%s")
#   local time_difference=$(expr $now - $last_update_time)
#
#   if [[ $time_difference -ge $one_day_in_seconds ]]; then
#     __update_plugin "$plugin"
#   fi
# }

local function __install_plugin() {
  local plugin="$1"
  local plugin_dir="$plugin_path/$plugin"

  if [[ -d "$plugin_dir" ]]; then
    echo "Installation of '$plugin' aborted, because plugin directory already exists."
    return 1
  fi
  echo "Installing '$plugin' into '$plugin_dir'..."
  git clone https://github.com/"$plugin".git "$plugin_dir"
  touch "$plugin_path"/"$plugin"_last_update
}

local function __update_plugin() {
  local plugin="$1"
  local plugin_dir="$plugin_path/$plugin"
  if [[ ! -d "$plugin_dir" ]]; then
    echo "Update aborted, because plugin '$plugin' could not be found."
    return 1
  fi
  #echo "Updating '$plugin'..."
  git --git-dir="$plugin_dir"/.git pull --no-rebase >/dev/null
  touch "$plugin_path"/"$plugin"_last_update
}

local function __load_plugin() {
  local plugin="$1"
  local plugin_dir="$plugin_path/$plugin"
  if [[ ! -d "$plugin_dir" ]]; then
    echo "Loading of plugin \"$plugin\" aborted, because it could not be found."
    return 1
  fi
  #echo "Loading '$plugin'..."
  source "$plugin_dir"/"$(basename "$plugin")".zsh
}

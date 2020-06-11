#!/bin/sh
# ------------------------------------------------------------------------------
# Dotfiles bootstrap script for zsh
# ------------------------------------------------------------------------------
# Marco Peluso
# marcopeluso.com
# marco AT pelu DOT so
# ------------------------------------------------------------------------------
# This script bootstraps this module by creating symbolic links to the
# relevant files at their default location.
#
# Usage: 'bootstrap.sh'


# creates symlinks
create_symlink() {
  target="$1"
  symlink="$2"

  # if target is a directory or regular file and no symlink exists
  if { [ -d "$target" ] || [ -f "$target" ]; } && [ ! -L "$symlink" ]; then
    ln -nfs "$target" "$symlink"
  else
    echo "ERROR: Couldn't create symlink '$symlink -> $target'"
  fi
}


# configure script
script_path=$(cd "$(dirname "$0")" && pwd -P)
payload_path="$script_path/payload"
zsh_temp_path="$HOME/.dotfiles-tmp/zsh"


# create temp and cache directories, if necessary
if [ ! -d "$zsh_temp_path" ]; then
  mkdir -p "$zsh_temp_path"
fi
if [ ! -d "$zsh_temp_path/cache" ]; then
  mkdir -p "$zsh_temp_path/cache"
fi


# create relevant symlinks to module payload
target="$payload_path/zsh"
symlink="$HOME/.zsh"
create_symlink "$target" "$symlink"

target="$payload_path/zsh/zshenv"
symlink="$HOME/.zshenv"
create_symlink "$target" "$symlink"

target="$payload_path/zsh/zshrc"
symlink="$HOME/.zshrc"
create_symlink "$target" "$symlink"


# make zsh the default shell
chsh -s $(which zsh)

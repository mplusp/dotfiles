#!/bin/sh
# ------------------------------------------------------------------------------
# Bootstrap script for git dotfiles.
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

# create relevant symlinks to module payload
target="$payload_path/gitconfig"
symlink="$HOME/.gitconfig"
create_symlink "$target" "$symlink"

target="$payload_path/gitignore"
symlink="$HOME/.gitignore"
create_symlink "$target" "$symlink"


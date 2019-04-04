#!/bin/sh
# ------------------------------------------------------------------------------
# Bootstrap script for test dotfiles.
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
# test-payload1
target="$payload_path/test-payload1"
symlink="$HOME/.dotfiles-test-module2-payload1"
create_symlink "$target" "$symlink"

# test-payload2
target="$payload_path/nested/nested-test-payload1"
symlink="$HOME/.dotfiles-test-module2-nested-payload1"
create_symlink "$target" "$symlink"


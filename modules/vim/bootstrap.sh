#!/bin/sh
# ------------------------------------------------------------------------------
# Bootstrap script for vim dotfiles.
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
vim_temp_path="$HOME/.dotfiles-tmp/vim"


# create temp/backup/swap/undo directories, if necessary
if [ ! -d "$vim_temp_path/backup" ]; then
  mkdir -p "$vim_temp_path/backup"
fi

if [ ! -d "$vim_temp_path/swap" ]; then
  mkdir -p "$vim_temp_path/swap"
fi

if [ ! -d "$vim_temp_path/undo" ]; then
  mkdir -p "$vim_temp_path/undo"
fi


# create vim-plug plugins directory, if necessary
if [ ! -d "$vim_temp_path/plugged" ]; then
  mkdir -p "$vim_temp_path/plugged"
fi


# create actual payload/vim directory, if necessary
if [ ! -d "$payload_path/vim" ]; then
  mkdir -p "$payload_path/vim"
fi


# create relevant symlinks to module payload
target="$payload_path/vimrc"
symlink="$HOME/.vimrc"
create_symlink "$target" "$symlink"

target="$payload_path/vim"
symlink="$HOME/.vim"
create_symlink "$target" "$symlink"


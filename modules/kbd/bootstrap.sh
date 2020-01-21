#!/bin/sh
# ------------------------------------------------------------------------------
# Bootstrap script for keymap configuration using kbd.
# ------------------------------------------------------------------------------
# Marco Peluso
# marcopeluso.com
# marco AT pelu DOT so
# ------------------------------------------------------------------------------
# This script bootstraps this module by creating symbolic links to the
# relevant files at their default location and changing relevant config files.
#
# This script is meant to be run by the main bootstrap script, but you can
# also run it manually.
#
# Usage: 'bootstrap.sh'
#
# TODO: - remove the need to call this via "sudo -E" by asking for sudo privileges


# sudo if necessary
if [ $EUID -ne 0 ]; then
	sudo -E "$0" "$@"
	exit $?
fi


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
keymap_path="$payload_path/keymaps"
module_name=".$(basename $script_path)"

# create relevant symlinks to module payload
target="$payload_path"
symlink="$HOME/$module_name"
create_symlink "$target" "$symlink"

# add entries for available keymaps to '/etc/vconsole.conf'
available_keymaps="$keymap_path"/*
for keymap in $available_keymaps
do
	echo "KEYMAP=$target/keymaps/$(basename $keymap)" >> "/etc/vconsole.conf"
done


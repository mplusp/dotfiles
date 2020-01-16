#!/bin/sh
# ------------------------------------------------------------------------------
# Bootstrap script for our dotfiles.
# ------------------------------------------------------------------------------
# Marco Peluso
# marcopeluso.com
# marco AT pelu DOT so
# ------------------------------------------------------------------------------
# This script bootstraps our dotfiles, using a simple module based approach.
#
# Modules are just directories inside the modules directory.
# Each module contains its own bootstrap script and the relevant payload for
# that module.
#
# This script just runs the bootstrap script contained in each module.
#
# The modules' bootstrap scripts can also be run on their own.
#
# Usage:
#   - to install a single module:          'bootstrap.sh module'
#   - to install multiple modules at once: 'bootstrap.sh module1 module2 ...'
#   - to install all available modules:    'bootstrap.sh'


# configure script
script_path=$(cd "$(dirname "$0")" && pwd -P)
modules_path="$script_path/modules"
modules_bootstrap_script="bootstrap.sh"


# given no arguments
if [ $# -eq 0 ]; then
  echo "usage: bootstrap.sh --all | --list | modulename | modulename ..."
fi


# given one argument
if [ $# -eq 1 ]; then
  if [ "$1" = "--all" ]; then
    # all available modules should be bootstrapped
    modules_to_install="$modules_path"/*
  elif [ "$1" = "--list" ]; then
    # list available modules
    available_modules="$modules_path"/*
    for module in $available_modules
    do
      echo "$(basename $module)"
    done
  else
    # given module should be bootstrapped
    modules_to_install="$modules_path/$1"
  fi
fi


# given more than one argument
if [ $# -gt 1 ]; then
  # all given modules should be bootstrapped
  for module in $@
  do
    modules_to_install="$modules_to_install $modules_path/$module"
  done
fi


# actually try to bootstrap the modules
for module in $modules_to_install
do
  # check for existing and executable module bootstrap script
  if [ -x "$module/$modules_bootstrap_script" ]; then
    "$module/$modules_bootstrap_script"
    #"$modules_path/$module/$modules_bootstrap_script"
  else
    echo "ERROR: Could not execute '$module/$modules_bootstrap_script'."
    echo "Are you sure, that it exists and is executable?"
  fi
done


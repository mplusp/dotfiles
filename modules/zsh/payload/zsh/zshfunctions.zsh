#!/bin/zsh
# ------------------------------------------------------------------------------
# zsh function definitions
# ------------------------------------------------------------------------------
# Marco Peluso
# marcopeluso.com
# marco AT pelu DOT so
# ------------------------------------------------------------------------------
# This file isn't automatically sourced.
# Source it via .zshrc or another appropriate zsh startup file.
# ------------------------------------------------------------------------------


# general
# ------------------------------------------------------------------------------
# Make directory and directly cd into it. Supports directory hierarchies and
# spaces in directory names.
function mkcd() {
  mkdir -p "$*"
  cd "$*"
}

# 'ff x' finds a file named x from the current directory downwards and prints
# it's path. Works with wildcards.
function ff() {
  find . -name "$1" -print
}

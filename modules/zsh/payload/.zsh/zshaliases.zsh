#!/bin/zsh
# ------------------------------------------------------------------------------
# Alias definitions for zsh.
# ------------------------------------------------------------------------------
# Marco Peluso
# marcopeluso.com
# marco AT pelu DOT so
# ------------------------------------------------------------------------------
# This file isn't automatically executed.
# Source it via .zshrc or another zsh startup file.
# ------------------------------------------------------------------------------


# zsh
# ------------------------------------------------------------------------------
# source .zshrc
alias szshrc='source ~/.zsh/.zshrc'


# ls
# ------------------------------------------------------------------------------
# list files and directories in long mode
alias l='ls -lhF'

# list files and directories in long mode (including hidden ones)
alias la='ls -lahF'

# list only hidden files and directories in long mode
alias lh='ls -lhdF .*'

# list only directories in long mode
alias ld='ls -lhdF *(/)'


# cd
# ------------------------------------------------------------------------------
alias cdn='cd ~/nextcloud'
alias cddf='cd ~/nextcloud/dotfiles'

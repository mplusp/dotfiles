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
alias cddevlab='cd ~/nextcloud/dev/lab'
alias cdmobappex='cd ~/nextcloud/fra-uas/Module/current/m22-mobile-application-exercises-2001-liebehenschel-data-visualization/git/mobappex'
alias cdmobdev1='cd ~/nextcloud-unisharing/mob-devices/00-projects/01-project-1/marco'
alias cdmobdev2='cd ~/nextcloud-unisharing/mob-devices/00-projects/02-project-2/marco'
alias cdswed='cd ~/nextcloud-unisharing/swe-d/03-collaboration/00-git'

# other
# ------------------------------------------------------------------------------
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

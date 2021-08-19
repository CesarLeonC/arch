#################################################
#     Name: Cesar Leon C.
#     E-mail: leoncesaralejandro@gmail.com
#     Type: Dot File
#     Date: August, the 18th/ 2021
#     Description: .zshenv file
#################################################

###################################
# 1. Exports
###################################
## General variables
export EDITOR="nvim"
export VISUAL="nvim"

## XDG related variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

## Zsh configuration variables
export ZDOT_DIR="$XSG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

## Emacs related
export PATH=~/.emacs.d/bin:$PATH

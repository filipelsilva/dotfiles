#!/bin/bash

# Install neovim plugins
nvim -c ":PlugInstall" -c "q" -c "q"
nvim -c ":so ~/.config/nvim/init.vim" -c "q" -c "q"

# Set default shell
chsh -s "$(command -v zsh)"

# Set completion theme
zsh -c "source ~/.zshrc"

echo "Put this in ~/.profile:
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
setxkbmap -option shift:both_capslock"

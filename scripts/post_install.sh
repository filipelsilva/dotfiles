#!/bin/bash

# Install neovim plugins
nvim -c ":PackUpdate"
nvim -c ":so $HOME/.config/nvim/init.vim" -c "q" -c "q"

# Set default shell
chsh -s "$(command -v zsh)"

# Set completion theme
zsh -c "source $HOME/.zshrc"

echo "Put this in .profile:
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'
setxkbmap -option shift:both_capslock"

echo "Put this in .inputrc:
set editing-mode vi"

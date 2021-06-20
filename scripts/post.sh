#!/bin/bash

# Install neovim plugins
nvim -c ":PackUpdate"
nvim -c ":so $HOME/.config/nvim/init.vim" -c "q" -c "q"

# Set default shell
chsh -s "$(command -v zsh)"
zsh -c "source $HOME/.zshrc"

# Set completion theme
#zsh -c "fast-theme forest"

# Vi mode in other programs
echo "set editing-mode vi" >> $HOME/.inputrc

# Swap ESC with CAPS
echo "setxkbmap -option caps:swapescape" >> $HOME/.profile

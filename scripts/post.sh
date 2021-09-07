#!/bin/bash

# Set default shell
chsh -s "$(command -v zsh)"
zsh -c "source $HOME/.zshrc"

# Vi mode in other programs
echo "set editing-mode vi" >> $HOME/.inputrc

# Advice for plugins in (Neo)Vim
echo "Do not forget to run ':PackUpdate' in Vim/Neovim!"

# For my keyboard, US international mode (altgr variant)
#echo "setxkbmap -layout us -variant altgr-intl" >> $HOME/.profile

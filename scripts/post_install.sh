#!/bin/bash

# To solve vim-startify
#touch ~/.viminfo

# For (n)vim's startify
#mkdir -p ~/.vim/files/info

# Neovim Plugins
nvim -c ":PlugInstall" -c "q" -c "q"
nvim -c ":so ~/.config/nvim/init.vim" -c "q"

# Set default shell
chsh -s "$(command -v zsh)"

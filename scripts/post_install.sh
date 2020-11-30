#!/bin/bash

# Install neovim plugins
nvim -c ":PlugInstall" -c "q" -c "q"
nvim -c ":so ~/.config/nvim/init.vim" -c "q"

# For deoplete
pip3 install --user pynvim

# Set default shell
chsh -s "$(command -v zsh)"

#!/bin/bash

# Install neovim Plugins
nvim -c ":PlugInstall" -c "q" -c "q"
nvim -c ":so ~/.config/nvim/init.vim" -c "q"

# Set default shell
chsh -s "$(command -v zsh)"

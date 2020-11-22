#!/bin/bash

# Install neovim plugins
nvim -c ":PlugInstall" -c "q" -c "q"
nvim -c ":so ~/.config/nvim/init.vim" -c "q"

# Set gh cli stuff
gh config set git_protocol ssh
gh config set editor nvim
# gh auth login

# Set default shell
chsh -s "$(command -v zsh)"

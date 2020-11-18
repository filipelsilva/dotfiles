#!/bin/bash

# For (n)vim's startify
oldvim -c "wqa"

# Neovim Plugins
vim -c "PlugInstall" -c "q" -c "q"

# Set default shell
chsh -s "$(command -v zsh)"

#!/bin/bash

mkdir $HOME/.zsh

# Zsh-vi-mode
git clone https://github.com/jeffreytse/zsh-vi-mode.git $HOME/.zsh/zsh-vi-mode

# Zoxide
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sudo sh

# Fast syntax highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.zsh/fast-syntax-highlighting

# Zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

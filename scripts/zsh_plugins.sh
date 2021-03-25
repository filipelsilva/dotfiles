#!/bin/bash

mkdir -p $HOME/.zsh

# Zoxide
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sudo sh

# Forgit
git clone https://github.com/wfxr/forgit $HOME/.zsh/forgit

# Fast syntax highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting.git $HOME/.zsh/fast-syntax-highlighting

# Zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

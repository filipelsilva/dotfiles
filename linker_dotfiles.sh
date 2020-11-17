#!/bin/bash

# For (n)vim's startify
mkdir -p ~/.vim/files/info

# Dotfiles
cd ~ || return
rm ~/.zshrc
mkdir -p .config/nvim
ln -s ~/dotfiles/init.vim .config/nvim/
ln -s ~/dotfiles/.alacritty.yml ~
ln -s ~/dotfiles/.zshrc ~
ln -s ~/dotfiles/.tmux.conf ~
ln -s ~/dotfiles/.gitconfig ~
ln -s ~/dotfiles/starship.toml .config/

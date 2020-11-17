#!/bin/bash

cd ~ || return

# For (n)vim's startify
mkdir -p ~/.vim/files/info

# Dotfiles
cd ~ || return
rm ~/.zshrc
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/files/init.vim ~/.config/nvim/
ln -s ~/dotfiles/files/.alacritty.yml ~
ln -s ~/dotfiles/files/.zshrc ~
ln -s ~/dotfiles/files/.tmux.conf ~
ln -s ~/dotfiles/files/.gitconfig ~
ln -s ~/dotfiles/files/starship.toml ~/.config/

#!/bin/bash

cd ~ || return

# Dotfiles
rm ~/.zshrc
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/files/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/files/alacritty.yml ~/.alacritty.yml
ln -s ~/dotfiles/files/zshrc ~/.zshrc
ln -s ~/dotfiles/files/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/files/gitconfig ~/.gitconfig
ln -s ~/dotfiles/files/starship.toml ~/.config/starship.toml

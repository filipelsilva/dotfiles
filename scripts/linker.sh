#!/bin/bash

# Dotfiles
rm $HOME/.zshrc
mkdir -p $HOME/.config/nvim
ln -s $HOME/dotfiles/files/init.vim $HOME/.config/nvim/init.vim
ln -s $HOME/dotfiles/files/alacritty.yml $HOME/.alacritty.yml
ln -s $HOME/dotfiles/files/zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/files/tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/files/gitconfig $HOME/.gitconfig

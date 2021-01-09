#!/bin/bash

# Dotfiles
rm ~/.zshrc
mkdir -p ~/.config/nvim
mkdir -p ~/.config/kitty
mkdir -p ~/.zsh
ln -s ~/dotfiles/files/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/files/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/dotfiles/files/alacritty.yml ~/.alacritty.yml
ln -s ~/dotfiles/files/zshrc ~/.zshrc
ln -s ~/dotfiles/files/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/files/tmate.conf ~/.tmate.conf
ln -s ~/dotfiles/files/gitconfig ~/.gitconfig
ln -s ~/dotfiles/files/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/files/filipe.zsh-theme ~/.oh-my-zsh/custom/themes/filipe.zsh-theme
ln -s ~/dotfiles/files/filipe2.zsh-theme ~/.oh-my-zsh/custom/themes/filipe2.zsh-theme
ln -s ~/dotfiles/files/zsh/fp ~/.zsh/fp
ln -s ~/dotfiles/files/zsh/kp ~/.zsh/kp

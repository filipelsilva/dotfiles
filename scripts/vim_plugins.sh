#!/bin/bash

# To solve vim-startify
#touch ~/.viminfo

# For (n)vim's startify
mkdir -p ~/.vim/files/info

# Neovim Plugins
nvim -c "PlugInstall" -c "q" -c "q"

# Vim VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovim VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


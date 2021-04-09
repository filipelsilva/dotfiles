#!/bin/bash

# Vim Minpac
git clone https://github.com/k-takata/minpac.git $HOME/.vim/pack/minpac/opt/minpac

# Neovim Minpac
git clone https://github.com/k-takata/minpac.git $HOME/.config/nvim/pack/minpac/opt/minpac

# # Vim VimPlug
# curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# # Neovim VimPlug
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#!/bin/bash

# Update; upgrade; install stuff
sudo pacman -Syu --noconfirm zsh git curl wget glances htop neovim go python \
    python-pip python-setuptools gcc valgrind gdb unzip zip tmux p7zip lynx \
    ripgrep fd the_silver_searcher nodejs npm neofetch screenfetch pkg-config \
    make entr clang-format

# GUI: meld, vscode, discord, obs-studio, etc.

#!/bin/bash

cd ~ || return

# Update; upgrade; install stuff
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y zsh git curl wget glances htop neovim golang python3-dev\
    python3-pip python3-setuptools gcc valgrind gdb unzip zip tmux p7zip-full\
    p7zip-rar lynx ripgrep fd-find silversearcher-ag nodejs npm neofetch screenfetch

# GUI: meld, vscode, etc.

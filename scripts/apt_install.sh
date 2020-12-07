#!/bin/bash

# Update; upgrade; install stuff
sudo apt-get -qq update  
sudo apt-get -qq -y upgrade  
sudo apt-get install -qq -y zsh git curl wget glances htop neovim golang python3-dev\
    python3-pip python3-setuptools gcc valgrind gdb unzip zip tmux p7zip-full make\
    lynx ripgrep fd-find silversearcher-ag nodejs npm neofetch screenfetch entr\
    clang-format
# GUI: meld, vscode, discord, obs-studio, etc.

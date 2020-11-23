#!/bin/bash

cd ~ || return

# Update; upgrade; install stuff
#[ "$UID" -eq 0 ] || { echo "This script must be run as root."; exit 1; }
sudo apt-get -qq update && sudo apt-get -qq -y upgrade
sudo apt-get install -qq -y zsh git curl wget glances htop neovim golang python3-dev\
    python3-pip python3-setuptools gcc valgrind gdb unzip zip tmux p7zip-full\
    p7zip-rar lynx ripgrep fd-find silversearcher-ag nodejs npm neofetch screenfetch

# GUI: meld, vscode, discord, obs-studio, etc.

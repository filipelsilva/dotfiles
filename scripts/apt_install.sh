#!/bin/bash

cd ~ || return

# Workaround
sudo echo "Getting password..."

# Gh cli
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C99B11DEB97541F0 > /dev/null
sudo apt-add-repository https://cli.github.com/packages > /dev/null

# Update; upgrade; install stuff
sudo apt-get -qq update > /dev/null
sudo apt-get -qq -y upgrade > /dev/null
sudo apt-get install -qq -y zsh git curl wget glances htop neovim golang python3-dev\
    python3-pip python3-setuptools gcc valgrind gdb unzip zip tmux gh p7zip-full\
    p7zip-rar lynx ripgrep fd-find silversearcher-ag nodejs npm neofetch screenfetch > /dev/null

# GUI: meld, vscode, discord, obs-studio, etc.

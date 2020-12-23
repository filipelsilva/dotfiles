#!/bin/bash

# Update; upgrade; install stuff
if ( command -v apt-get &> /dev/null ); then

    sudo apt-get -qq update  
    sudo apt-get -qq -y upgrade  
    sudo apt-get install -qq -y zsh git curl wget glances htop neovim golang\
        python3-dev python3-pip python3-setuptools gcc valgrind gdb unzip zip\
        tmux tmate p7zip-full make lynx ripgrep fd-find silversearcher-ag\
        nodejs npm neofetch screenfetch entr clang-format

elif ( command -v pacman &> /dev/null ); then

    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm zsh git curl wget glances htop neovim go \
        python-pip python python-setuptools gcc valgrind gdb unzip zip tmux \
        tmate p7zip lynx ripgrep fd the_silver_searcher nodejs npm neofetch \
        screenfetch pkg-config make entr clang

elif ( command -v dnf &> /dev/null ); then

    sudo dnf -y upgrade
    sudo dnf -y install zsh git curl wget glances htop neovim golang\
        python3-devel python3-pip python3-setuptools gcc valgrind gdb unzip\
        zip tmux tmate p7zip make lynx ripgrep fd-find the_silver_searcher\
        nodejs npm neofetch screenfetch entr clang util-linux-user openssl-devel

fi

# GUI: meld, vscode, discord, obs-studio, etc.

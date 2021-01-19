#!/bin/bash

# Update; upgrade; install stuff
if ( command -v apt-get &> /dev/null ); then

    sudo apt-get -qq update  
    sudo apt-get -qq -y upgrade  
    sudo apt-get install -qq -y zsh git curl wget glances htop neovim\
        python3-dev python3-pip python3-setuptools gcc valgrind gdb unzip zip\
        tmux tmate p7zip-full make lynx ripgrep fd-find silversearcher-ag\
        nodejs npm neofetch screenfetch entr rlwrap ctags hexyl bat

elif ( command -v pacman &> /dev/null ); then

    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm zsh git curl wget glances htop neovim python-pip\
        python python-setuptools gcc valgrind gdb unzip zip tmux tmate p7zip\
        lynx ripgrep fd the_silver_searcher nodejs npm neofetch screenfetch\
        pkg-config make entr rlwrap ctags hexyl bat
    sudo pacman -S --noconfirm exa tokei hyperfine
    ./scripts/yay_programs.sh

fi

# GUI: meld, vscode, discord, obs-studio, etc.

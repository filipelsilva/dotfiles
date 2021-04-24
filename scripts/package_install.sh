#!/bin/bash

if ( command -v apt-get &> /dev/null ); then

    sudo apt-get -qq update
    sudo apt-get -qq -y upgrade
    sudo apt-get install -qq -y zsh git curl wget glances htop neovim xclip\
        python3-dev python3-pip python3-setuptools gcc valgrind gdb unzip zip\
        tmux make lynx ripgrep fd-find silversearcher-ag nodejs npm neofetch\
        screenfetch entr rlwrap exuberant-ctags hexyl bat cmake shellcheck\
        perf pypy

elif ( command -v pacman &> /dev/null ); then

    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm zsh git curl wget glances htop neovim python-pip\
        python python-setuptools pypy gcc valgrind gdb unzip zip tmux lynx perf\
        ripgrep fd the_silver_searcher nodejs npm neofetch screenfetch xclip\
        pkg-config make entr rlwrap ctags hexyl bat cmake shellcheck exa\
        hyperfine
    ./scripts/aur_programs.sh

fi

#!/bin/bash

# Update; upgrade; install stuff
sudo dnf upgrade
sudo dnf install -y zsh git curl wget glances htop neovim golang python3-devel\
    python3-pip python3-setuptools gcc valgrind gdb unzip zip tmux tmate p7zip\
    make lynx ripgrep fd-find the_silver_searcher nodejs npm neofetch screenfetch\
    entr clang util-linux-user openssl-devel

# GUI: meld, vscode, discord, obs-studio, etc.

#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm zsh git curl wget glances htop neovim python-pip\
    python python-setuptools pypy gcc valgrind gdb unzip zip tmux lynx tree\
    ripgrep fd the_silver_searcher neofetch screenfetch xclip pkg-config go\
    make entr rlwrap ctags hexyl bat cmake shellcheck hyperfine onefetch\
    progress npm atool pacman-contrib zsh-completions ascii playerctl

# For manual installation:
#sudo pacman -S --noconfirm alacritty i3 i3status i3lock dmenu feh arandr\
#    maim pavucontrol xdotool arc-gtk-theme lxappearance thunar autorandr\
#    thunar-archive-plugin file-roller nomacs okular brightnessctl

#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm zsh git curl wget glances htop neovim python-pip\
    python python-setuptools pypy gcc valgrind gdb unzip zip tmux lynx tree\
    ripgrep fd the_silver_searcher neofetch screenfetch xclip pkg-config go\
    make entr rlwrap ctags hexyl bat cmake shellcheck hyperfine onefetch\
    progress npm atool pacman-contrib zsh-completions ascii nodejs playerctl\
    brightnessctl zoxide

# For desktop installation:

# sudo pacman -S --noconfirm alacritty i3 i3status i3lock maim rofi feh arandr\
#     nomacs pavucontrol xdotool arc-gtk-theme lxappearance thunar autorandr\
#     thunar-archive-plugin file-roller okular xss-lock\
#     ttc-iosevka ttc-iosevka-ss12

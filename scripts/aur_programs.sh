#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/aur.git ~/.aur
(cd ~/.aur && makepkg -si)

aur -S --noconfirm tealdeer git-delta lazygit topgrade bottom dust sd neovim-nightly-git
# Extras: 
# aur -S --noconfirm optimus-manager ttf-iosevka ttf-iosevka-term

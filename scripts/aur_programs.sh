#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/paru.git ~/.paru
(cd ~/.paru && makepkg -si)

paru -S --noconfirm tealdeer git-delta topgrade 
# Extras: 
# paru -S --noconfirm optimus-manager ttf-iosevka ttf-iosevka-term

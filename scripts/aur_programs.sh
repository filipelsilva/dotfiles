#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/aur.git ~/.aur
(cd ~/.aur && makepkg -si)

aur -S --noconfirm tealdeer git-delta topgrade bottom dust sd
# Extras: 
# aur -S --noconfirm optimus-manager ttf-iosevka ttf-iosevka-term

#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $HOME/.yay
(cd $HOME/.yay && makepkg -si)

yay -S --noconfirm tealdeer sd

# Install manually:
#yay -S --noconfirm ttf-iosevka ttf-iosevka-term ttf-iosevka-ss12 ttf-iosevka-term-ss12

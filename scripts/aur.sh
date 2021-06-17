#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $HOME/.yay
(cd $HOME/.yay && makepkg -si)

yay -S --noconfirm tealdeer bottom sd zoxide-git duf
# Extras:
# yay -S --noconfirm optimus-manager ttf-iosevka ttf-iosevka-term

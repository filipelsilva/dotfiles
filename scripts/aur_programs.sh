#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $HOME/.yay
(cd $HOME/.yay && makepkg -si)

yay -S --noconfirm tealdeer git-delta topgrade bottom dust sd zoxide-git
# Extras:
# yay -S --noconfirm optimus-manager ttf-iosevka ttf-iosevka-term

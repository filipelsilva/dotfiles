#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/.yay
(cd ~/.yay && makepkg -si)

yay -S --noconfirm tealdeer git-delta lazygit topgrade bottom dust sd
# Extras:
# yay -S --noconfirm optimus-manager ttf-iosevka ttf-iosevka-term

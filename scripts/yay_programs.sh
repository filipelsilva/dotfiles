#!/bin/bash

pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/.yay
(cd ~/.yay && makepkg -si)

yay -S tealdeer git-delta topgrade

#!/bin/bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $HOME/.yay
(cd $HOME/.yay && makepkg -si)

yay -S --noconfirm tealdeer sd zoxide-git

# Install manually:
#yay -S --noconfirm ttf-iosevka ttf-iosevka-term ly

# And for ly:
#sudo systemctl enable ly
#sudo systemctl disable getty@tty2.service

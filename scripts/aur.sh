#!/usr/bin/env bash

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $HOME/.yay
(cd $HOME/.yay && makepkg -si)

yay -S --noconfirm \
	gef \
	cht.sh-git \
	tealdeer \
	downgrade \
	vimv-git \
	rr \
	python-gdbgui \
	linux-wifi-hotspot \

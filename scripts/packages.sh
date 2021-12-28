#!/usr/bin/env bash

packages=(
	linux
	linux-firmware
	base
	base-devel
	zsh
	zsh-completions
	bash
	bash-completion
	gvim
	neovim
	tmux
	tmuxp
	git
	zoxide
	zip
	unzip
	atool
	curl
	wget
	htop
	glances
	tree
	python
	python-pip
	python-pynvim
	bpython
	python-internetarchive
	pypy
	gcc
	gdb
	pwndbg
	valgrind
	fzy
	fzf
	fd
	the_silver_searcher
	ripgrep
	ripgrep-all
	neofetch
	xclip
	pkg-config
	shellcheck
	make
	cmake
	ctags
	entr
	rlwrap
	hexyl
	bat
	hyperfine
	npm
	ascii
	go
	nodejs
	jq
	pacman-contrib
	lynx
	dnsutils
	tk
)

desktop_packages=(
	alacritty
	firefox
	torbrowser-launcher
	i3
	i3status
	i3lock
	xss-lock
	rofi
	arandr
	autorandr
	feh
	nomacs
	maim
	pavucontrol
	xdotool
	arc-gtk-theme
	lxappearance
	xdg-user-dirs
	thunar
	thunar-archive-plugin
	file-roller
	okular
	redshift
	playerctl
	brightnessctl
	ttc-iosevka
	ttc-iosevka-ss12
)

if [[ $1 = "full" ]]; then
	packages+=(${desktop_packages[@]})
fi

sudo pacman -Syu --noconfirm ${packages[@]}

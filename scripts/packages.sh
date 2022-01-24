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
	vi
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
	python-internetarchive
	pypy
	bpython
	gcc
	gdb
	pwndbg
	valgrind
	cloc
	tokei
	fzy
	fzf
	fd
	the_silver_searcher
	ripgrep
	ripgrep-all
	gping
	duf
	dust
	diskus
	neofetch
	onefetch
	terminus-font
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
	tealdeer
	ascii
	go
	rustup
	nodejs
	npm
	jq
	pacman-contrib
	sysstat
	iftop
	lynx
	dnsutils
	tk
	time
	words
)

desktop_packages=(
	alacritty
	firefox
	ffmpeg
	handbrake
	vlc
	mpv
	transmission-cli
	transmission-gtk
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
	zathura
	zathura-djvu
	zathura-pdf-mupdf
	zathura-ps
	redshift
	playerctl
	brightnessctl
	tesseract
	tesseract-data-por
	tesseract-data-eng
	ttc-iosevka
	ttc-iosevka-ss12
	ttf-hack
)

if [[ $1 = "full" ]]; then
	packages+=(${desktop_packages[@]})
fi

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm ${packages[@]}

# For the rustup package, so that rustc and cargo work out of the box
rustup self update

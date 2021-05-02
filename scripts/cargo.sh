#!/bin/bash

# Cargo is already installed with yay (AUR)
if ( command -v apt-get &> /dev/null ); then
	# Rustc / Rustup / Cargo
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source $HOME/.cargo/env

	cargo install exa hyperfine tealdeer topgrade bottom du-dust sd zoxide
fi

# Programs (Arch already has most of these in Pacman/AUR)
cargo install cargo-update

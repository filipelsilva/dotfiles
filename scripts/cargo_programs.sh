#!/bin/bash

# Rustc / Rustup / Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Programs (Arch already has most of these in Pacman/AUR)
cargo install cargo-update

if ( command -v apt-get &> /dev/null ); then
	cargo install exa hyperfine tealdeer git-delta topgrade bottom du-dust sd
fi

#!/bin/bash

# Rustc / Rustup / Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Programs (Arch already has most of these in Pacman/AUR)
cargo install cargo-update

git clone https://github.com/mosmeh/indexa ~/indexa
(cd ~/indexa && cargo install --path .)
rm -rf ~/indexa

if ( command -v apt-get &> /dev/null ); then
	cargo install exa tokei hyperfine tealdeer git-delta topgrade bottom du-dust sd
fi

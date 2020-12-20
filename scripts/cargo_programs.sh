#!/bin/bash

# Rustc / Rustup / Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Programs
cargo install hexyl exa bat tokei tealdeer hyperfine cargo-update git-delta topgrade

git clone https://github.com/mosmeh/indexa ~/indexa
(cd ~/indexa && cargo install --path .)
rm -rf ~/indexa

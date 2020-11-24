#!/bin/bash

# Rustc / Rustup / Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Programs
cargo install hexyl exa bat hyperfine cargo-update

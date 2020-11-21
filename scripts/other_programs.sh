#!/bin/bash

cd ~ || return

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Tmuxp
sudo pip3 install tmuxp

# TheFuck
sudo pip3 install thefuck

# Bpytop
sudo pip3 install bpytop --upgrade

# Forgit
git clone https://github.com/wfxr/forgit ~/.config/forgit

# Gh cli
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt-get update && sudo apt-get install gh

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git ~/.gdb-peda-pwndbg-gef
cd ~/.gdb-peda-pwndbg-gef
./install.sh
cd ~ || return

# Hexyl
wget https://github.com/sharkdp/hexyl/releases/download/v0.8.0/hexyl-musl_0.8.0_amd64.deb
sudo dpkg -i hexyl-musl_0.8.0_amd64.deb
rm hexyl-musl_0.8.0_amd64.deb

# Exa
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
sudo mv exa-linux-x86_64 /usr/local/bin/exa
rm exa-linux-x86_64-0.9.0.zip

# Bat
wget https://github.com/sharkdp/bat/releases/download/v0.16.0/bat-musl_0.16.0_amd64.deb
sudo dpkg -i bat-musl_0.16.0_amd64.deb
rm bat-musl_0.16.0_amd64.deb

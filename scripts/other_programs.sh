#!/bin/bash

cd ~ || return

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Forgit
git clone https://github.com/wfxr/forgit ~/.config/forgit

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git ~/.gdb-peda-pwndbg-gef
cd ~/.gdb-peda-pwndbg-gef
./install.sh

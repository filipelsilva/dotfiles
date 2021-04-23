#!/bin/bash

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --all

# Cheat.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git $HOME/.gdb-peda-pwndbg-gef
(cd $HOME/.gdb-peda-pwndbg-gef && ./install.sh)

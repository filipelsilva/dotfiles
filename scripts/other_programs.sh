#!/bin/bash

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Cheat.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git ~/.gdb-peda-pwndbg-gef
(cd ~/.gdb-peda-pwndbg-gef && ./install.sh)

#!/bin/bash

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Forgit
git clone https://github.com/wfxr/forgit ~/.config/forgit

# Bat-extras (specifically: batdiff)
git clone https://github.com/eth-p/bat-extras ~/.bat-extras
(cd ~/.bat-extras && sudo ./build.sh)
sudo mv ~/.bat-extras/bin/batdiff /usr/local/bin
rm -rf ~/.bat-extras

# Cheat.sh
curl https://cht.sh/:cht.sh | sudo tee /usr/local/bin/cht.sh
sudo chmod +x /usr/local/bin/cht.sh

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git ~/.gdb-peda-pwndbg-gef
(cd ~/.gdb-peda-pwndbg-gef && ./install.sh)

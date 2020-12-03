#!/bin/bash

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Forgit
git clone https://github.com/wfxr/forgit ~/.config/forgit

# Bat-extras (requisites)
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

npm install --save-dev --save-exact prettier
echo {}> ~/.prettierrc.json

# Bat-extras
git clone https://github.com/eth-p/bat-extras ~/.bat-extras
(cd bat-extras && sudo ./build.sh && sudo mv bin/* /usr/local/bin)

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git ~/.gdb-peda-pwndbg-gef
(cd ~/.gdb-peda-pwndbg-gef && ./install.sh)

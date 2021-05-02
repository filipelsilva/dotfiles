#!/bin/bash

curl -s https://webinstall.dev/node | bash
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Node
webi node

# Packages
npm install -g diff-so-fancy

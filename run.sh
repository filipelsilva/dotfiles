#!/bin/bash

./scripts/apt_install.sh 2>&1 /dev/null
./scripts/other_programs.sh 2>&1 /dev/null
./scripts/zsh_plugins.sh 2>&1 /dev/null
./scripts/vim_plugins.sh 2>&1 /dev/null
./scripts/linker_dotfiles.sh 2>&1 /dev/null

#!/bin/bash

./scripts/apt_install.sh > /dev/null 2>&1
./scripts/other_programs.sh > /dev/null 2>&1
./scripts/zsh_plugins.sh > /dev/null 2>&1
./scripts/vim_plugins.sh > /dev/null 2>&1
./scripts/linker_dotfiles.sh > /dev/null 2>&1

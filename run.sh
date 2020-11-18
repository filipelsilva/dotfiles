#!/bin/bash

echo "Beggining instalation"
echo "Installing apt packages..."
./scripts/apt_install.sh > /dev/null 2>&1
echo "Installing other programs..."
./scripts/other_programs.sh > /dev/null 2>&1
echo "Installing zsh plugins..."
./scripts/zsh_plugins.sh > /dev/null 2>&1
echo "Installing vim plugin managers..."
./scripts/vim_plugins.sh > /dev/null 2>&1
echo "Linking dotfiles..."
./scripts/linker_dotfiles.sh > /dev/null 2>&1
echo "Post instalation things..."
./scripts/post_install.sh

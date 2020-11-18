#!/bin/bash

echo "#########################"
echo "# Beggining instalation #"
echo "#########################"
echo "# 1. Installing apt packages (this will take a while)..."
./scripts/apt_install.sh > /dev/null 2>&1
echo "# 2. Installing other programs (this will also take a while)..."
./scripts/other_programs.sh > /dev/null 2>&1
echo "# 3. Installing zsh plugins..."
./scripts/zsh_plugins.sh > /dev/null 2>&1
echo "# 4. Installing vim plugin managers..."
./scripts/vim_plugins.sh > /dev/null 2>&1
echo "# 5. Linking dotfiles..."
./scripts/linker_dotfiles.sh > /dev/null 2>&1
echo "# 6. Post instalation things..."
./scripts/post_install.sh

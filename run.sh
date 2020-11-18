#!/bin/bash

redirect="> /dev/null 2>&1"

echo "#########################"
echo "# Beggining instalation #"
echo "#########################"
echo "# 1. Installing apt packages (this will take a while)..."
./scripts/apt_install.sh "$redirect"
echo "# 2. Installing other programs (this will also take a while)..."
./scripts/other_programs.sh "$redirect"
echo "# 3. Installing zsh plugins..."
./scripts/zsh_plugins.sh "$redirect"
echo "# 4. Installing vim plugin managers..."
./scripts/vim_plugins.sh "$redirect"
echo "# 5. Linking dotfiles..."
./scripts/linker_dotfiles.sh "$redirect"
echo "# 6. Post instalation things..."
./scripts/post_install.sh

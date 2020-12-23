#!/bin/bash

echo "#########################"
echo "# Beggining instalation #"
echo "#########################"

sudo -s echo "# Getting password..."

echo "# 1. Getting the system up to date and installing apt packages (this will take a while)..."
./scripts/package_install.sh

echo "# 2. Installing other programs (this will also take a while)..."
echo "# 2.1. Pip"
./scripts/pip_programs.sh
echo "# 2.2. Cargo"
./scripts/cargo_programs.sh
echo "# 2.3. Miscellaneous"
./scripts/other_programs.sh

echo "# 3. Installing zsh plugins..."
./scripts/zsh_plugins.sh

echo "# 4. Installing vim plugin managers..."
./scripts/vim_plugins.sh

echo "# 5. Linking dotfiles..."
./scripts/linker_dotfiles.sh

echo "# 6. Post instalation things..."
./scripts/post_install.sh

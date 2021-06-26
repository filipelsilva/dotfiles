#!/bin/bash

echo "#########################"
echo "# Beggining instalation #"
echo "#########################"

sudo echo "# Getting password..."

echo "# 1. Getting the system up to date and installing packages (this will take a while)..."
./scripts/packages.sh

echo "# 2. Installing other programs (this will also take a while)..."
echo "# 2.1. Pip"
./scripts/pip.sh
echo "# 2.2. Cargo"
./scripts/cargo.sh
echo "# 2.3. Miscellaneous"
./scripts/other.sh

echo "# 3. Installing zsh plugins..."
./scripts/zsh.sh

echo "# 4. Installing vim plugin managers..."
./scripts/vim.sh

echo "# 5. Linking dotfiles..."
./scripts/linker.sh

echo "# 6. Post instalation things..."
./scripts/post.sh

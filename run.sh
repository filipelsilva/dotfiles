#!/bin/bash

echo "#########################"
echo "# Beggining instalation #"
echo "#########################"

sudo echo "# Getting password..."

echo "# 1. Pacman"
./scripts/packages.sh

echo "# 2. Cargo"
./scripts/cargo.sh

echo "# 3. AUR"
./scripts/aur.sh

echo "# 4. Pip"
./scripts/pip.sh

echo "# 5. Miscellaneous"
./scripts/other.sh

echo "# 6. Installing zsh plugins..."
./scripts/zsh.sh

echo "# 7. Installing vim plugin managers..."
./scripts/vim.sh

echo "# 8. Linking dotfiles..."
./scripts/linker.sh

echo "# 9. Post instalation things..."
./scripts/post.sh

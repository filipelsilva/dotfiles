#!/bin/bash

echo "#########################"
echo "# Beggining instalation #"
echo "#########################"

sudo echo "# Getting password..."

echo "# 1. Linker"
stow headless
if [[ $1 = "full" ]]; then
	stow desktop
fi

echo "# 2. Pacman"
./scripts/packages.sh $1

echo "# 3. AUR"
./scripts/aur.sh $1

echo "# 4. Post instalation things..."
./scripts/post.sh $1

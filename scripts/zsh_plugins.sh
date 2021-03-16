#!/bin/bash

# Oh-my-zsh
rm ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zoxide
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | sudo sh

# Fast syntax highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Exa aliases
git clone https://github.com/DarrinTisdale/zsh-aliases-exa ~/.oh-my-zsh/custom/plugins/zsh-aliases-exa

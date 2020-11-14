#!/bin/bash

cd ~ || return

# The basics
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y zsh git curl wget glances htop neovim python3-dev\
    python3-pip python3-setuptools gcc valgrind gdb unzip zip tmux p7zip-full\
    p7zip-rar lynx ripgrep fd-find nodejs npm

# Fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# TheFuck
sudo pip3 install thefuck

# Tmuxp
sudo pip3 install tmuxp

# Forgit
git clone https://github.com/wfxr/forgit ~/.config/forgit

# Jump Shell
wget https://github.com/gsamokovarov/jump/releases/download/v0.30.1/jump_0.30.1_amd64.deb
sudo dpkg -i jump_0.30.1_amd64.deb
rm jump_0.30.1_amd64.deb

# Gh cli
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt-get update && sudo apt-get install gh

# Vim VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Neovim VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# For (n)vim's startify
mkdir -p ~/.vim/files/info

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Oh-my-zsh
rm ~/.zshrc
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship
curl -fsSL https://starship.rs/install.sh | bash

# Pwndbg + gef + peda (GDB)
git clone https://github.com/filipelsilva/gdb-peda-pwndbg-gef.git ~/.gdb-peda-pwndbg-gef
cd ~/.gdb-peda-pwndbg-gef
sudo ./install.sh
cd ..

# Hexyl
wget https://github.com/sharkdp/hexyl/releases/download/v0.8.0/hexyl-musl_0.8.0_amd64.deb
sudo dpkg -i hexyl-musl_0.8.0_amd64.deb
rm hexyl-musl_0.8.0_amd64.deb

# Exa
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
sudo mv exa-linux-x86_64 /usr/local/bin/exa
rm exa-linux-x86_64-0.9.0.zip

# Bat
wget https://github.com/sharkdp/bat/releases/download/v0.16.0/bat-musl_0.16.0_amd64.deb
sudo dpkg -i bat-musl_0.16.0_amd64.deb
rm bat-musl_0.16.0_amd64.deb

## Zsh plugins
# Fast syntax highlighting
git clone https://github.com/zdharma/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

# Zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Exa aliases
git clone https://github.com/DarrinTisdale/zsh-aliases-exa ~/.oh-my-zsh/custom/plugins/zsh-aliases-exa
##

# Dotfiles
cd ~ || return
rm ~/.zshrc
mkdir -p .config/nvim
ln -s ~/dotfiles/init.vim .config/nvim/
ln -s ~/dotfiles/.alacritty.yml ~
ln -s ~/dotfiles/.zshrc ~
ln -s ~/dotfiles/.tmux.conf ~
ln -s ~/dotfiles/.gitconfig ~
ln -s ~/dotfiles/starship.toml .config/

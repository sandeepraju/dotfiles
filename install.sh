#!/bin/bash

# Install SSH config
echo "installing ssh config file"
mkdir -p ~/.ssh/
cp ssh/config ~/.ssh/

# Install terminator config
echo "installing terminator config file"
mkdir -p ~/.config/terminator/
cp terminator/config ~/.config/terminator/

# Install git config
echo "installing git config file"
cp git/config ~/.gitconfig
cp git/ignore  ~/.gitignore

# Install PyPI config
echo "installing PyPI config file"
cp python/pypirc ~/.pypirc

# Install Postgres PSQL config
echo "installing psql config file"
cp postgres/psqlrc  ~/.psqlrc

# Install zsh config
echo "installing zsh config file"
cp zsh/osx/zshrc ~/.zshrc

# Install emacs config
echo "installing emacs config file"
mkdir -p ~/.emacs.d/
cp emacs/init.el ~/.emacs.d/init.el

# Install mg config
echo "installing mg config file"
cp mg/mg ~/.mg

# Install vagrant file
echo "setting up vagrant"
cp vagrant/Vagrantfile ~/Vagrantfile

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
cp zsh/osx/zshrc ~/.zshrc

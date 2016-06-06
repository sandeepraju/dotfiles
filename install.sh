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

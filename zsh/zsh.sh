#!/usr/bin/env bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Configuration files
ln -fs ~/dotfiles/zsh/.{zshrc,zprofile} ~/

# If you want to hide the last login banner on logging
touch ~/.hushlogin

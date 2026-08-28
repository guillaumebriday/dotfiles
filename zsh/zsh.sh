#!/usr/bin/env bash

# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Configuration files
ln -fs ~/dotfiles/zsh/.{zshrc,zprofile} ~/

# If you want to hide the last login banner on logging
touch ~/.hushlogin

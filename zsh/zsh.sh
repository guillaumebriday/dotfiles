#!/usr/bin/env bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Configuration files
ln -fs ~/dotfiles/zsh/.zshrc ~/

# If you want to hide the last login banner on logging
touch ~/.hushlogin

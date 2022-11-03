#!/usr/bin/env bash

# Configuration files
find ~/dotfiles/vscode -name '*.json' -maxdepth 1 -print0 | xargs -0 -I file ln -fs file ~/Library/Application\ Support/VSCodium/User/

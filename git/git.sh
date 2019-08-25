#!/usr/bin/env bash

find ~/dotfiles/git -name '.git*' | xargs -I file ln -fs file ~/

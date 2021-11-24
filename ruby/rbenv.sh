#!/usr/bin/env bash

# Configuration files
ln -fs ~/dotfiles/ruby/.gemrc ~/
ln -fs ~/dotfiles/ruby/.irbrc ~/

# Installing and setting latest version of Ruby
rbenv install 2.7.5
rbenv global 2.7.5

# Installing default gems
gem install bundler rails awesome_print

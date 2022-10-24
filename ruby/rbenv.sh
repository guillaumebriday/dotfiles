#!/usr/bin/env bash

# Configuration files
ln -fs ~/dotfiles/ruby/.{gemrc,irbrc} ~/

# Installing and setting latest version of Ruby
rbenv install 3.1.2
rbenv global 3.1.2

# Installing default gems
gem install bundler rails awesome_print

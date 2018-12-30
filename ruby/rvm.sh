#!/usr/bin/env bash

# Check for rvm
if test ! $(which rvm)
then
  echo "Installing rvm for you."
  curl -sSL https://get.rvm.io | bash -s stable
fi

# Upgrading to the latest repository source version
rvm get head

# Installing and setting latest version of Ruby
rvm install ruby --latest
rvm use ruby --latest --default

# Installing default gems
gem install bundler rails awesome_print docker-sync

# Configuration files
ln -fs ~/dotfiles/ruby/.gemrc ~/
ln -fs ~/dotfiles/ruby/.irbrc ~/

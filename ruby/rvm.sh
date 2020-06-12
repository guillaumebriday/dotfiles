#!/usr/bin/env bash

# Configuration files
ln -fs ~/dotfiles/ruby/.gemrc ~/
ln -fs ~/dotfiles/ruby/.irbrc ~/

# Check for rvm
if ! hash rvm 2>/dev/null; then
  echo "Installing rvm for you."
  curl -sSL https://rvm.io/mpapis.asc | gpg --import -
  curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
  curl -sSL https://get.rvm.io | bash -s stable
fi

# Upgrading to the latest repository source version
rvm get head --auto-dotfiles

# Installing and setting latest version of Ruby
rvm install ruby --latest
rvm use ruby --latest --default

# Installing default gems
gem install bundler rails awesome_print

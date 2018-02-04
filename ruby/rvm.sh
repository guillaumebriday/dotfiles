#!/usr/bin/env bash

# Check for rvm
if test ! $(which rvm)
then
  echo "Installing rvm for you."
  ruby -e "$(curl -sSL https://get.rvm.io | bash -s stable)"
fi

# Upgrading to the latest repository source version
rvm get head

# Installing and setting latest version of Ruby
rvm install ruby --latest
rvm use ruby --latest --default

# Installing Bundler
gem install bundler

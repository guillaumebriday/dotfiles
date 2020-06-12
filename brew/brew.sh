#!/usr/bin/env bash

# Check for Homebrew
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew for you."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew bundle --file=brew/Brewfile

# Remove outdated versions from the cellar.
brew cleanup

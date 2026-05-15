#!/usr/bin/env bash

# Check for Homebrew
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew bundle --file=brew/Brewfile.core

# Remove outdated versions from the cellar.
brew cleanup

# Install Claude Code
if ! hash claude 2>/dev/null; then
  echo "Installing Claude Code for you."
  curl -fsSL https://claude.ai/install.sh | bash
fi

# Install Scalingo CLI
if ! hash scalingo 2>/dev/null; then
  echo "Installing Scalingo CLI for you."
  curl -O https://cli-dl.scalingo.io/install && bash install && rm install
fi

# Install mise
if ! hash mise 2>/dev/null; then
  echo "Installing mise for you."
  curl https://mise.run | sh
fi

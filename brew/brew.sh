#!/usr/bin/env bash
set -euo pipefail

# Check for Homebrew
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # A fresh install is not on PATH yet, and nothing below works without it
  for prefix in /opt/homebrew /usr/local; do
    if [ -x "$prefix/bin/brew" ]; then
      eval "$("$prefix/bin/brew" shellenv)"
      break
    fi
  done
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# One unavailable cask should not stop the rest of the bootstrap
if ! brew bundle --file ~/dotfiles/brew/Brewfile.core; then
  echo "Some entries in Brewfile.core did not install, see above." >&2
fi

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

  # Their installer drops a file next to you, so keep it out of the repo
  (
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT
    cd "$tmp"
    curl -fsSL -O https://cli-dl.scalingo.io/install
    bash install
  )
fi

# Install mise
if ! hash mise 2>/dev/null; then
  echo "Installing mise for you."
  curl -fsSL https://mise.run | sh
fi

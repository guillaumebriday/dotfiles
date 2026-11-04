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

# shellcheck source=brew/lib.sh
source ~/dotfiles/brew/lib.sh

# A trimmed copy can stand in for the repo's list, so a machine can skip some
# tools without leaving edits to a tracked file behind
brewfile=${BREWFILE_CORE:-$HOME/dotfiles/brew/Brewfile.core}

# update, upgrade and cleanup are housekeeping: a formula from some tap we never
# asked for, or one flaky download, should not take the whole bootstrap with it

# Make sure we’re using the latest Homebrew.
brew update || echo "Homebrew did not update, carrying on with the version on disk" >&2

trust_taps "$brewfile"

# Upgrade any already-installed formulae.
brew upgrade || echo "Some formulae did not upgrade, see above." >&2

# One unavailable cask should not stop the rest of the bootstrap
if ! brew bundle --file "$brewfile"; then
  echo "Some entries in $brewfile did not install, see above." >&2
fi

# Remove outdated versions from the cellar.
brew cleanup || echo "Cleanup did not finish, see above." >&2

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

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

# Homebrew 6 refuses to load anything from a third-party tap until that tap is
# trusted, which is enough to stop brew bundle dead. The taps a Brewfile asks
# for are ones we picked ourselves, so trust them before bundling. Anything
# else on the machine stays untrusted on purpose.
trust_taps () {
  local file=$1 tap

  # Older Homebrew has no trust at all, and needs none
  brew trust --help >/dev/null 2>&1 || return 0

  while read -r tap; do
    [ -n "$tap" ] || continue
    echo "==> Trusting the $tap tap"
    brew trust "$tap"
  done < <(sed -n "s/^[[:space:]]*tap[[:space:]]*[\'\"]\([^\'\"]*\)[\'\"].*/\1/p" "$file")
}

# update, upgrade and cleanup are housekeeping: a formula from some tap we never
# asked for, or one flaky download, should not take the whole bootstrap with it

# Make sure we’re using the latest Homebrew.
brew update || echo "Homebrew did not update, carrying on with the version on disk" >&2

trust_taps ~/dotfiles/brew/Brewfile.core

# Upgrade any already-installed formulae.
brew upgrade || echo "Some formulae did not upgrade, see above." >&2

# One unavailable cask should not stop the rest of the bootstrap
if ! brew bundle --file ~/dotfiles/brew/Brewfile.core; then
  echo "Some entries in Brewfile.core did not install, see above." >&2
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

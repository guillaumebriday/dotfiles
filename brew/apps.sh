#!/usr/bin/env bash
set -euo pipefail

# The GUI applications in brew/Brewfile. They live apart from Brewfile.core so
# a machine can take the command line tools without dragging in every app.

if ! hash brew 2>/dev/null; then
  echo "Homebrew is not on PATH yet. Run install.sh brew first." >&2
  exit 1
fi

# shellcheck source=brew/lib.sh
source ~/dotfiles/brew/lib.sh

trust_taps ~/dotfiles/brew/Brewfile

# One unavailable cask should not stop the rest of the bootstrap
if ! brew bundle --file ~/dotfiles/brew/Brewfile; then
  echo "Some entries in Brewfile did not install, see above." >&2
fi

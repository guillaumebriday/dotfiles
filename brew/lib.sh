#!/usr/bin/env bash
# Sourced by brew.sh and apps.sh, not meant to be run on its own.

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

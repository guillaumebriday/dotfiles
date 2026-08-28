#!/usr/bin/env bash
set -euo pipefail

# iTerm2 expands the tilde in this preference itself, so it must stay literal.
# shellcheck disable=SC2088
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iTerm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

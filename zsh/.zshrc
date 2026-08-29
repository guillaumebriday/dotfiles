# Interactive shell configuration. Environment variables live in .zshenv.

export ZSH="$HOME/.oh-my-zsh"
export ZSH_DISABLE_COMPFIX=true

ZSH_THEME="robbyrussell"

plugins=(git rails bundler macos docker docker-compose yarn)

HISTSIZE=50000
SAVEHIST=$HISTSIZE

# User configuration
# Extend the system PATH (/etc/paths and /etc/paths.d) instead of replacing it.
# `typeset -U` keeps the first occurrence of each entry, so nested shells and
# re-sourcing this file never duplicate anything.
typeset -U PATH path
path=(
  "$HOME/.local/bin"
  "$HOMEBREW_PREFIX/opt/postgresql@16/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$HOMEBREW_PREFIX/opt/libpq/bin"
  $path
  "$HOME/.composer/vendor/bin"
)

# Load mise
[ -x "$HOME/.local/bin/mise" ] && eval "$("$HOME/.local/bin/mise" activate zsh)"

source $ZSH/oh-my-zsh.sh

# Source zsh-autosuggestions and zsh-syntax-highlighting. Guarded so a fresh
# machine still gets a usable prompt before brew.sh has run.
# Syntax highlighting has to come last, after everything that defines widgets.
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  file="$HOMEBREW_PREFIX/share/$plugin/$plugin.zsh"
  [ -r "$file" ] && source "$file"
done

# Source aliases and functions:
for file in ~/dotfiles/zsh/.{aliases,functions,hidden}; do
  [ -r "$file" ] && source "$file"
done

# Google Cloud SDK path and completion, installed by the gcloud-cli cask.
for file in "$HOMEBREW_PREFIX"/share/google-cloud-sdk/{path,completion}.zsh.inc; do
  [ -r "$file" ] && source "$file"
done

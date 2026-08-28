#!/usr/bin/env bash
set -euo pipefail

REPO=https://github.com/guillaumebriday/dotfiles.git
LOCK=~/.dotfiles-install.lock

# Order matters: brew brings the tools the later steps rely on.
STEPS=(brew zsh macos git vim ssh ruby hosts iterm)

describe_step () {
  case "$1" in
    brew)  echo "Homebrew, then the packages and apps in brew/Brewfile.core" ;;
    zsh)   echo "Oh My Zsh, .zshrc and .zprofile" ;;
    macos) echo "macOS system preferences, needs your password" ;;
    git)   echo "git config files" ;;
    vim)   echo ".vimrc" ;;
    ssh)   echo "SSH config" ;;
    ruby)  echo ".gemrc and .irbrc" ;;
    hosts) echo "the update-hosts helper" ;;
    iterm) echo "iTerm2 preferences, close iTerm2 first" ;;
  esac
}

usage () {
  cat <<USAGE
usage: install.sh [-i] [step...]

Steps, in the order they run:
  ${STEPS[*]}

  -i, --interactive  ask which steps to run
  -h, --help         this message

On a brand new machine, run it straight from GitHub. It asks what you want and
clones the repo into ~/dotfiles:

  curl -fsSL https://raw.githubusercontent.com/guillaumebriday/dotfiles/master/install.sh | bash

Naming steps skips the questions, after -s -- in the curl form:

  curl -fsSL .../install.sh | bash -s -- git vim

Every step is idempotent, so re-running any of this is safe. Restart your
computer once the whole thing has finished.
USAGE
}

# Piped from curl, so there is no repo on disk yet: get one, then hand over to
# the checked-out copy so every step runs from a real file.
bootstrap () {
  if ! xcode-select -p >/dev/null 2>&1; then
    echo "==> Installing the Command Line Tools, git comes with them"
    xcode-select --install
    echo
    echo "Finish that installer, then run this command again."
    exit 1
  fi

  if [ -d ~/dotfiles ]; then
    echo "==> Using the existing ~/dotfiles"
  else
    echo "==> Cloning $REPO into ~/dotfiles"
    git clone "$REPO" ~/dotfiles
  fi

  # No arguments means nothing was chosen yet, so ask. stdin is the script
  # itself here, so the steps need the terminal handed back to them.
  if [ $# -eq 0 ]; then
    set -- --interactive
  fi

  if { true </dev/tty; } 2>/dev/null; then
    exec bash ~/dotfiles/install.sh "$@" </dev/tty
  fi

  exec bash ~/dotfiles/install.sh "$@"
}

# The picker writes to the terminal and returns the chosen steps on stdout,
# because stdin is the piped script in the curl flow.
pick_steps () {
  local answer step chosen=()

  {
    echo
    echo "What would you like to install?"
    echo
  } >/dev/tty

  printf "Everything? [Y/n] " >/dev/tty
  read -r answer </dev/tty || answer=""

  case "$answer" in
    [Nn]*) ;;
    *)
      printf '%s\n' "${STEPS[@]}"
      return
      ;;
  esac

  echo >/dev/tty

  for step in "${STEPS[@]}"; do
    printf "  %-5s  %-48s [Y/n] " "$step" "$(describe_step "$step")" >/dev/tty
    read -r answer </dev/tty || answer=""

    case "$answer" in
      [Nn]*) ;;
      *) chosen+=("$step") ;;
    esac
  done

  if [ ${#chosen[@]} -gt 0 ]; then
    printf '%s\n' "${chosen[@]}"
  fi
}

# One install at a time: a second run alongside the first would have two brews
# fighting over the same prefix.
acquire_lock () {
  local pid

  if mkdir "$LOCK" 2>/dev/null; then
    echo $$ >"$LOCK/pid"
    trap 'rm -rf "$LOCK"' EXIT
    return
  fi

  pid=$(cat "$LOCK/pid" 2>/dev/null || echo "")

  if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
    echo "An install is already running (pid $pid)." >&2
    exit 1
  fi

  echo "Ignoring the lock left behind by a run that did not finish"
  rm -rf "$LOCK"
  mkdir "$LOCK"
  echo $$ >"$LOCK/pid"
  trap 'rm -rf "$LOCK"' EXIT
}

run_step () {
  echo
  echo "==> $1"

  case "$1" in
    brew)  ~/dotfiles/brew/brew.sh ;;
    zsh)   ~/dotfiles/zsh/zsh.sh ;;
    macos) ~/dotfiles/macOS/macos.sh ;;
    git)   ~/dotfiles/git/git.sh ;;
    vim)   ~/dotfiles/vim/vim.sh ;;
    ssh)   ~/dotfiles/ssh/ssh.sh ;;
    ruby)  ~/dotfiles/ruby/ruby.sh ;;
    hosts) ~/dotfiles/hosts/hosts.sh ;;
    iterm)
      # iTerm2 rewrites its preferences on quit, so it would undo this.
      # pgrep does not see GUI apps reliably, ask the app itself instead.
      if [ "$(osascript -e 'application "iTerm" is running' 2>/dev/null)" = "true" ]; then
        echo "iTerm2 is running and would overwrite these settings. Skipping."
        echo "Close it and run: install.sh iterm"
        return
      fi

      ~/dotfiles/iTerm2/iterm.sh
      ;;
    *)
      echo "Unknown step: $1" >&2
      return 1
      ;;
  esac
}

# BASH_SOURCE is unset only when bash is reading the script from stdin
if [ -z "${BASH_SOURCE[0]:-}" ]; then
  bootstrap "$@"
fi

interactive=0

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)        usage; exit 0 ;;
    -i|--interactive) interactive=1; shift ;;
    -*)
      echo "Unknown option: $1" >&2
      echo >&2
      usage >&2
      exit 1
      ;;
    *) break ;;
  esac
done

if [ "$interactive" -eq 1 ] && [ $# -eq 0 ]; then
  selected=()

  while read -r step; do
    [ -n "$step" ] && selected+=("$step")
  done <<<"$(pick_steps)"

  if [ ${#selected[@]} -eq 0 ]; then
    echo "Nothing selected, so nothing to do."
    exit 0
  fi

  set -- "${selected[@]}"
fi

if [ $# -eq 0 ]; then
  set -- "${STEPS[@]}"
fi

# Validate up front so a typo cannot fail halfway through the bootstrap
for step in "$@"; do
  case " ${STEPS[*]} " in
    *" $step "*) ;;
    *)
      echo "Unknown step: $step" >&2
      echo >&2
      usage >&2
      exit 1
      ;;
  esac
done

acquire_lock

# ssh.sh copies its config by relative path, so every step runs from the repo
# rather than from wherever you happened to launch this
cd ~/dotfiles

for step in "$@"; do
  if ! run_step "$step"; then
    echo
    echo "FAILED on the $step step. Nothing after it ran."
    echo "Fix it, then pick up where it stopped: install.sh $step"
    exit 1
  fi
done

echo
echo "Done. Restart your computer to pick up everything."

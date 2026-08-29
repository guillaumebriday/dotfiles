# Sourced by every zsh (including scripts and non-interactive shells), so this
# is where variables that tools need to see live. Interactive-only setup that
# depends on oh-my-zsh or plugins belongs in .zshrc.

export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR=vim

# .zprofile overwrites this with `brew shellenv`, but that only runs for login
# shells: keep a default so non-login shells can still find brew's share/ dir.
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

export GATSBY_TELEMETRY_DISABLED=1
export DISABLE_BETTER_ERRORS=true
export DISABLE_RACK_MINI_PROFILER=true

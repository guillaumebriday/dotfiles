# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal macOS dotfiles. Shell scripts install/symlink config into `$HOME`. There is no build or test suite; the only automated check is ShellCheck.

## Commands

```bash
shellcheck --shell=bash install.sh */*.sh hosts/update-hosts   # lint (CI runs shellcheck on every push, .github/workflows/lint.yml)
./install.sh --help            # list steps
./install.sh git vim           # run specific steps only
./install.sh -i                # interactively pick steps
HOSTS_FILE=~/hosts-preview hosts/update-hosts   # dry-run the hosts blocklist against a copy instead of /etc/hosts
```

Running steps modifies the real machine (symlinks in `~`, `defaults write`, `brew bundle`, `/etc/hosts`), so don't run them to "test" a change without asking.

## Architecture

- **`install.sh` is the orchestrator.** `STEPS=(brew apps zsh macos git vim ssh ruby hosts iterm)` defines both the valid step names and the run order (brew first, since later steps need its tools). Adding a step means updating `STEPS`, `describe_step`, and `run_step`, plus the README.
- **Curl bootstrap:** when piped from curl (`BASH_SOURCE` unset), `bootstrap` installs Command Line Tools if needed, clones/fast-forwards `~/dotfiles`, then `exec`s the on-disk copy with `/dev/tty` as stdin. The interactive picker writes prompts to `/dev/tty` and returns choices on stdout for the same reason.
- **The repo is assumed to live at `~/dotfiles`.** Step scripts reference absolute `~/dotfiles/...` paths, and `install.sh` `cd`s there before running steps (`ssh/ssh.sh` copies by relative path). `install.sh` also takes a lock at `~/.dotfiles-install.lock` so only one run happens at a time.
- **Each directory has a `<name>.sh` step script** that is standalone-runnable, must be idempotent, and starts with `set -euo pipefail`. Most symlink files with `ln -fs ~/dotfiles/...  ~/`; `ssh/ssh.sh` copies instead of linking; `iTerm2/iterm.sh` points iTerm2 at this folder as its prefs directory (so `com.googlecode.iterm2.plist` gets rewritten by iTerm2 itself, and the step is skipped while iTerm2 is running).
- **Brew is split in two:** `brew/Brewfile.core` (CLI tools, `brew` step) and `brew/Brewfile` (GUI apps/casks, `apps` step). Both source `brew/lib.sh`, whose `trust_taps` trusts the taps declared in the Brewfile (required by Homebrew 6). Housekeeping (`update`, `upgrade`, `cleanup`, a failed bundle entry) is deliberately non-fatal. `brew.sh` also installs Claude Code, Scalingo CLI and mise via their own installers.
- **Zsh config split:** `.zshenv` holds env vars needed by every shell (including non-interactive); `.zshrc` holds interactive setup (oh-my-zsh, PATH via `typeset -U path`, plugins). `.zshrc` sources `zsh/.aliases`, `zsh/.functions`, and `zsh/.hidden` directly from the repo, so these are not symlinked. `zsh/.hidden` is gitignored for private/machine-specific aliases.
- **`hosts/update-hosts`** rewrites everything below a marker line in `/etc/hosts` with the StevenBlack list, keeping user entries above it. Domains to keep reachable go in its `ALLOWED` list; it refuses to write if the fetched list looks too small.

## Conventions

- ShellCheck: keep SC2088 enabled (see `.shellcheckrc`); suppress inline with a comment explaining why, as in `iTerm2/iterm.sh`.
- Comments explain *why* (e.g. why a failure is tolerated), not what.
- Commit messages are imperative and name the file touched, e.g. `Add rebase, mrspec and update_rubocop to zsh/.functions`.
- Keep README.md in sync when steps or usage change.

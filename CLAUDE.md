# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal macOS dotfiles. There is no build and there are no tests. The only check is ShellCheck, which CI (`.github/workflows/lint.yml`) runs on every push:

```bash
shellcheck --shell=bash install.sh lib/pick.sh brew/*.sh zsh/zsh.sh macOS/macos.sh git/git.sh vim/vim.sh ssh/ssh.sh ruby/ruby.sh hosts/hosts.sh hosts/update-hosts iTerm2/iterm.sh
```

`.shellcheckrc` keeps SC2088 (tilde in quotes) enabled on purpose. Where a tool expands the tilde itself, suppress it inline with a comment saying why, as `iTerm2/iterm.sh` does.

## How installation fits together

- `install.sh` is the single entry point. `STEPS=(brew apps zsh macos git vim ssh ruby hosts iterm)` sets the order, and the order matters because `brew` provides tools the later steps use. Each step maps to one `<dir>/<dir>.sh` script in `run_step`. A new step needs an entry in `STEPS`, `describe_step` and `run_step`, plus a README section.
- When it is piped from curl (`BASH_SOURCE` unset), `bootstrap` clones or fast-forwards `~/dotfiles`, then `exec`s the checked-out copy with `/dev/tty` as stdin.
- `-i` sources `lib/pick.sh`, a hand-written TUI checklist. It must stay **plain bash 3.2**: it runs on a new Mac before Homebrew exists, so it can't rely on fzf, gum or a newer bash. It draws to and reads from `/dev/tty`, not stdin.
- Package trimming never edits tracked Brewfiles. `choose_packages` writes a trimmed copy to a temp dir and exports `BREWFILE_CORE` (for `brew/brew.sh`, reading `brew/Brewfile.core`, which holds CLI tools) or `BREWFILE` (for `brew/apps.sh`, reading `brew/Brewfile`, which holds GUI apps and casks). `brew/lib.sh` `trust_taps` trusts the taps a Brewfile declares, which Homebrew 6 requires.
- A lock dir at `~/.dotfiles-install.lock` allows one install at a time. The run stops at the first failing step and tells the user how to resume from it.

## Conventions

- **Every script hard-codes `~/dotfiles`.** Configs are symlinked from there with `ln -fs` (zsh, git, vim, ruby, hosts). `ssh/config` is copied instead, by relative path, which is why `install.sh` `cd`s into the repo before running steps.
- Every step must be idempotent and start with `set -euo pipefail`. Housekeeping commands (`brew update`, `upgrade`, `cleanup`, `bundle`) warn instead of failing, so one bad formula doesn't abort the bootstrap.
- zsh config is split by purpose. `.zshenv` holds env vars every shell needs, including non-interactive ones. `.zshrc` holds interactive setup that depends on oh-my-zsh and plugins. `.zshrc` sources `zsh/.aliases`, `zsh/.functions` and `zsh/.hidden`. `.hidden` is gitignored and is where machine-local or secret settings go. Any other new file in `zsh/` is not sourced unless it is added to that loop.
- `hosts/update-hosts` rewrites only the part of `/etc/hosts` below its marker line. Domains that must keep resolving go in its `ALLOWED` list. Test it with `HOSTS_FILE=<copy> update-hosts`.
- Comments explain *why*, not what. Commit subjects are imperative and usually name the file they touch (e.g. "Add rebase, mrspec and update_rubocop to zsh/.functions").
- When changing install behaviour or adding a step, update `README.md` too, since it documents each step.

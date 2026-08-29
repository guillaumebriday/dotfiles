#!/usr/bin/env bash
set -euo pipefail

find ~/dotfiles/git -name '.git*' -print0 | xargs -0 -I file ln -fs file ~/

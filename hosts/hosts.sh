#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.local/bin
ln -fs ~/dotfiles/hosts/update-hosts ~/.local/bin/update-hosts

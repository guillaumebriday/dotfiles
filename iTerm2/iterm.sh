#!/bin/sh

cd "$(dirname "$0")" || exit 1

echo "Downloading iTerm2 Colors."
curl -sSL -o Arthur.itermcolors https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Arthur.itermcolors

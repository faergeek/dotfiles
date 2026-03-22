#!/bin/sh

set -eu

if [ $# -lt 1 ]; then
  echo "USAGE: $0 <file> [line] [column]"
  exit 1
fi

FILE="$1"
LNUM="${2:-1}"
COL="${3:-1}"

if [ -r ./nvim-server.pipe ]; then
  nvim --server ./nvim-server.pipe --remote "$FILE"
else
  kitty --single-instance -- nvim --listen ./nvim-server.pipe "$FILE"
fi

if [ "$LNUM" -gt 1 ] || [ "$COL" -gt 1 ]; then
  nvim --server ./nvim-server.pipe --remote-send "<C-\\><C-N>:call cursor($LNUM, $COL)<CR>"
fi

#!/usr/bin/env bash
set -eu
PREFIX="${PREFIX:-$HOME/.local}"
"$PREFIX/bin/animwall" stop 2>/dev/null || true
pkill -f 'animwall watch' 2>/dev/null || true
rm -f "$PREFIX/bin/animwall"
echo "removed $PREFIX/bin/animwall"
echo "kept your config (${XDG_CONFIG_HOME:-$HOME/.config}/animwall) and thumbnails; delete them by hand if you want."
echo "Remember to remove 'animwall watch' from your Hyprland config."

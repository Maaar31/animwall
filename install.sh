#!/usr/bin/env bash
# Installs animwall into ~/.local/bin and creates a default config.
set -eu
PREFIX="${PREFIX:-$HOME/.local}"
CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/animwall"
HERE="$(cd "$(dirname "$0")" && pwd)"

install -Dm755 "$HERE/bin/animwall" "$PREFIX/bin/animwall"
mkdir -p "$CONF_DIR"
if [ ! -f "$CONF_DIR/config" ]; then
  install -Dm644 "$HERE/config.example" "$CONF_DIR/config"
  echo "created $CONF_DIR/config"
else
  echo "kept existing $CONF_DIR/config"
fi
echo "installed $PREFIX/bin/animwall"

missing=()
for b in mpvpaper ffmpeg inotifywait flock caelestia; do
  command -v "$b" >/dev/null 2>&1 || missing+=("$b")
done
if [ ${#missing[@]} -gt 0 ]; then
  echo
  echo "missing: ${missing[*]}"
  echo "  Arch:  yay -S mpvpaper && sudo pacman -S ffmpeg inotify-tools util-linux"
  echo "  (caelestia is your existing Caelestia install)"
fi

case ":$PATH:" in
  *":$PREFIX/bin:"*) ;;
  *) echo; echo "$PREFIX/bin is not in your PATH. fish: fish_add_path $PREFIX/bin   bash/zsh: export PATH=\"$PREFIX/bin:\$PATH\"" ;;
esac

cat <<TXT

Next:
  1. animwall doctor
  2. put videos in your video folder, then: animwall sync
  3. start the daemon from your Hyprland config (see README, "Hyprland setup")
  4. pick an "$(grep -o 'THUMB_PREFIX="[^"]*"' "$HERE/bin/animwall" | head -n1 | cut -d'"' -f2)*" thumbnail in Caelestia's picker (launcher, then ">wallpaper")
TXT

#!/bin/sh
# Set niri's xkb options to the given argument and show a notification.
# Niri auto-reloads its config on file change, so the change takes effect
# immediately. Pass an empty string ("") to clear all options.
#
# Usage: set-xkb-options.sh <options>
# Example: set-xkb-options.sh ctrl:swapcaps
#          set-xkb-options.sh ""
set -eu

target=${1:-}
if [ "$#" -lt 1 ]; then
  echo "usage: $0 <options>" >&2
  exit 64
fi

c=~/.config/niri/config.kdl
notify_tag="niri_xkb_options"

# Escape ampersands and pipes for sed replacement (options strings are
# typically safe, but be defensive).
esc=$(printf '%s' "$target" | sed -e 's/[&|]/\\&/g')

# Replace the options value inside the xkb { } block. The pattern matches
#   <whitespace>options "...whatever..."
# (no trailing text) and rewrites it to <whitespace>options "$target".
if ! grep -qE "^[[:space:]]+options \"$target\"$" "$c"; then
  sed -i -E "s|^([[:space:]]+)options \".*\"$|\1options \"$esc\"|" "$c"
fi

notify-send -t 1000 \
  -h "string:x-dunst-stack-tag:$notify_tag" \
  "Keyboard options: ${target:-default}"
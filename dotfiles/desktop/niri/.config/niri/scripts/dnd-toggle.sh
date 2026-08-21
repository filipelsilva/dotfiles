#!/bin/sh
# Toggle dunst Do-Not-Disturb and show notification.
set -eu
notify_tag="sway_media_brightness_dnd_notifications"

notify-send -t 1000 \
  -h "string:x-dunst-stack-tag:$notify_tag" \
  "Notifications: $(dunstctl is-paused)"
sleep 0.5
dunstctl set-paused toggle
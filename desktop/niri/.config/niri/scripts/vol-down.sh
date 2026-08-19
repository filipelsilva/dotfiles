#!/bin/sh
# Volume down: decrease default sink volume by 5% and show notification.
set -eu
notify_tag="sway_media_brightness_dnd_notifications"

wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
v=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
notify-send -t 1000 \
  -h "string:x-dunst-stack-tag:$notify_tag" \
  -h "int:value:$v" \
  "Volume: $v%"
#!/bin/sh
# Brightness up: increase backlight by 5% and show notification.
set -eu
notify_tag="sway_media_brightness_dnd_notifications"

brightnessctl --class=backlight set 5%+
b=$(brightnessctl -c backlight | awk -F"[()%]" '/Current/ {print $2}')
notify-send -t 1000 \
  -h "string:x-dunst-stack-tag:$notify_tag" \
  -h "int:value:$b" \
  "Brightness: $b%"
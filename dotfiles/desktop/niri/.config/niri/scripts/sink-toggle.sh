#!/bin/sh
# Toggle mute on the default audio sink and show notification.
set -eu
notify_tag="niri_media_brightness_dnd_notifications"

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
state=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo muted || echo on)
notify-send -t 1000 -h "string:x-dunst-stack-tag:$notify_tag" "[Speaker] $state"
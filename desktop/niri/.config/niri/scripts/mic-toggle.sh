#!/bin/sh

# Toggle mute on the default audio source (microphone) and show notification.

set -eu
notify_tag="niri_media_brightness_dnd_notifications"

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
state=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo muted || echo on)
notify-send -t 1000 -h "string:x-dunst-stack-tag:$notify_tag" "[Microphone] $state"
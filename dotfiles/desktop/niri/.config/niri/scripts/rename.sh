#!/usr/bin/env bash

options=("-theme" "gruvbox-dark-hard" "-font" "'Iosevka Nerd Font 14'")
rename="Rename"
reset="Reset"
cancel="Cancel"

function run_rofi_selection() {
  echo -e "$rename\n$reset\n$cancel" | rofi "${options[@]}" -dmenu -p "Change Workspace Name"
}

function get_name() {
  echo "" | rofi "${options[@]}" -dmenu -p "New Workspace Name:" -l 0
}

function main() {
  chosen="$(run_rofi_selection)"
  case $chosen in
    "$rename")
      niri msg action set-workspace-name "$(get_name)"
    ;;
    "$reset")
      niri msg action unset-workspace-name
    ;;
  esac
}

main

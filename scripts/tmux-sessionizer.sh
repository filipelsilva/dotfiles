#!/usr/bin/env bash

sessions=()
folders=( "$(find -L "$HOME/src" -mindepth 2 -maxdepth 2 -type d)" )

tmux_running=$(pgrep tmux)
if [[ $tmux_running ]]; then
	custom_sessions=$(tmux list-sessions -F "#{session_name}")
	for session in $custom_sessions; do
		[[ ! ${folders[*]} =~ $session ]] && sessions+=("$session")
	done
fi

sessions+=("${folders[@]}")
[[ ! ${sessions[*]} =~ "default" ]] && sessions=("default" "${sessions[@]}")

if ! command -v fzf > /dev/null 2>&1; then
	select folder in "${sessions[@]}"; do
		selected=$folder
		break
	done
else
	selected=$(printf "%s\n" "${sessions[@]}" | fzf)
fi

if [[ -z $selected ]]; then
	exit 0
fi

if [[ $selected == "default" ]]; then
	selected=$HOME
	selected_name="default"
else
	selected_name="$(basename "$selected" | tr . _)"
fi

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
	tmux new-session -ds "$selected_name" -c "$selected"
fi

if [[ -z $TMUX ]]; then
	tmux attach-session -t "$selected_name"
else
	tmux switch-client -t "$selected_name"
fi

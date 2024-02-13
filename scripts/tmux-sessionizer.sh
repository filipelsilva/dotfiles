#!/bin/bash

sessions=$(cat <(echo default) <(find "$HOME/src" -mindepth 2 -maxdepth 2 -type d))

if ! command -v fzf &> /dev/null; then
	select folder in $sessions; do
		selected=$folder
		break
	done
else
	selected=$(echo "$sessions" | fzf)
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

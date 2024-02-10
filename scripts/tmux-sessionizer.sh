#!/bin/bash

command="find "$HOME/src" -mindepth 2 -maxdepth 2 -type d"

if ! command -v fzf &> /dev/null; then
	select folder in $($command); do
		selected=$folder
		break
	done
else
	selected=$($command -print0 |
		xargs -0 -n1 zoxide query --list --score |
		sort -urnk1 |
		fzf --no-sort |
		awk '{print $2}')
fi

if [[ -z $selected ]]; then
	exit 0
fi

selected_name="$(basename "$selected" | tr . _)"

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
	echo tmux new-session -ds "$selected_name" -c "$selected"
	tmux new-session -ds "$selected_name" -c "$selected"
fi

if [[ -z $TMUX ]]; then
	echo tmux attach-session -t "$selected_name"
	tmux attach-session -t "$selected_name"
else
	echo tmux switch-client -t "$selected_name"
	tmux switch-client -t "$selected_name"
fi

switchSession() {
	selected=$(tmux ls -F \#S | fzf --no-sort)

	if [[ -z $selected ]]; then
		exit 0
	fi

	if [[ -z $TMUX ]] ; then
		tmux attach-session -t "$selected"
	else
		tmux switch-client -t "$selected"
	fi
}

newSessionOrSwitch() {
	selected=$(find "$HOME/src" -mindepth 2 -maxdepth 2 -type d | fzf)

	if [[ -z $selected ]]; then
		exit 0
	fi

	selected_name="$(basename "$selected" | tr . _)"
	echo "$selected_name"

	if [[ -z $TMUX ]]; then
		echo tmux new-session -s "$selected_name" -c "$selected"
		exit 0
	fi

	if ! tmux has-session -t="$selected_name" 2> /dev/null; then
		echo tmux new-session -ds "$selected_name" -c "$selected"
	fi

	echo tmux switch-client -t "$selected_name"
}

tmux_running="$(pgrep tmux)"
if [[ -z $tmux_running ]]; then
	tmux new-session -d -s default
	echo "Starting tmux..."
	sleep 2
fi

if [[ $1 = "new" ]]; then
	newSessionOrSwitch
else
	switchSession
fi

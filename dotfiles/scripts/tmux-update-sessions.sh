#!/usr/bin/env bash

# Keep tmux sessions in sync with projects under:
#   ~/src/<category>/<project>

set -u

FOLDER="$HOME/src"

function sanitize_session_name() {
	echo "$1" | tr '.:' '__'
}

function create_session() {
	path="$1"
	session_name="$(basename "$path")"
	echo "creating session '$session_name' with path '$path'"
	tmux new-session -ds "$session_name" -c "$FOLDER/$path"
}

function reconcile() {
	# Get existing sessions
	existing_sessions=$(tmux list-sessions -F "#{session_name}")

	# Get all wanted paths + "default" session
	mapfile -t wanted_paths < <(find -L "$FOLDER" -mindepth 2 -maxdepth 2 -type d -printf '%P\n')
	wanted_paths+=("default")

	# Create sessions that are not present
	for wanted in "${wanted_paths[@]}"; do
		sanitized=$(sanitize_session_name "$wanted")
		if [[ ! ${existing_sessions[*]} =~ $(basename "$sanitized") ]]; then
			create_session "$sanitized"
		fi
	done
}

tmux_running=$(pgrep tmux)
if [[ ! $tmux_running ]]; then
	echo "start tmux before running this"
	exit 1
fi

if [[ ! -d  $FOLDER ]]; then
	mkdir -p "$FOLDER"
fi

reconcile

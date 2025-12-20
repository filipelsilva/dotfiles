#!/usr/bin/env bash

# This script's assuming the following directory structure:
# FOLDER
# FOLDER/<category>/<project>
# ...
#
# Example:
# FOLDER/university/nlp-project
# FOLDER/university/ia-project
# FOLDER/work/project-one
# FOLDER/work/project-two
#
# This way, we can just get the <project> folder and avoid searching for Git
# folders and the like. It also follows my mental structure for organization.
# Change line 21 if you don't agree :D

FOLDER="$HOME/src"

function sanitize_session_names() {
	echo "$*" | tr '.:' '__'
}

sessions=()
if [[ -d $FOLDER ]]; then
	folders=( "$(find -L "$FOLDER" -mindepth 2 -maxdepth 2 -type d)" )
else
	folders=()
fi

tmux_running=$(pgrep tmux)
if [[ $tmux_running ]]; then
	custom_sessions=$(tmux list-sessions -F "#{session_name}")
	sanitize_session_namesd_sessions=$(sanitize_session_names "${folders[*]}")
	for session in $custom_sessions; do
		[[ ! ${sanitize_session_namesd_sessions[*]} =~ $session ]] && sessions+=("$session")
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

selected_sanitized=$(sanitize_session_names "$selected")

if [[ $selected_sanitized == "default" ]]; then
	selected_sanitized=$HOME
	selected_name="default"
else
	selected_name="$(basename "$selected_sanitized")"
fi

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
	tmux new-session -ds "$selected_name" -c "$selected"
fi

if [[ -z $TMUX ]]; then
	tmux attach-session -t "$selected_name"
else
	tmux switch-client -t "$selected_name"
fi

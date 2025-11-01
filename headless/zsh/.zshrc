# Plugins {{{
export ZIT_MODULES_PATH="${HOME}/.zit.d"
if [[ ! -d "${ZIT_MODULES_PATH}/zit" ]]; then
	git clone "https://github.com/thiagokokada/zit" "${ZIT_MODULES_PATH}/zit"
fi
source "${ZIT_MODULES_PATH}/zit/zit.zsh"

zit-install "https://github.com/thiagokokada/zit" "zit"
if (( $+commands[fzf] )); then
	zit-install-load "https://github.com/wfxr/forgit#main" "forgit" "forgit.plugin.zsh"
fi

zit-install-load "https://github.com/mafredri/zsh-async#main" "zsh-async" "async.zsh"

(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd j)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
# }}}

# Variables {{{
# PATH and related variables {{{
export PATH
typeset -U PATH

if (( $+commands[python] )); then
	export PYTHONDONTWRITEBYTECODE=1
	local pathAdd="$HOME/.local/bin"
	[[ -d $pathAdd ]] && PATH="$PATH:$pathAdd"
fi

(( $+commands[cargo] )) && PATH="$PATH:$HOME/.cargo/bin"

if (( $+commands[go] )); then
	export GOPATH="$HOME/.go"
	export PATH="$PATH:$GOPATH/bin"
fi

if (( $+commands[java] )); then
	local pathAdd="/usr/lib/jvm/default"
	if [[ -d $pathAdd ]]; then
		export JAVA_HOME=$pathAdd
		PATH="$PATH:$JAVA_HOME/bin"
	fi
fi

if (( $+commands[gem] )); then
	local pathAdd="$(ruby -e 'puts Gem.user_dir')"
	if [[ -d $pathAdd ]]; then
		export GEM_HOME=$pathAdd
		PATH="$PATH:$GEM_HOME/bin"
	fi
fi
# }}}

# Editor stuff
if (( $+commands[nvim] )); then
	export EDITOR="nvim"
	export EDITOR_MANPAGER="nvim +Man!"
else
	export EDITOR="vim"
	export EDITOR_MANPAGER="env MAN_PN=1 vim -M +MANPAGER -"
fi
export VISUAL="$EDITOR"
export DIFFPROG="$EDITOR -d"

# LESS/MANPAGER
export LESS="--ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen"
export MANPAGER="less"

# Terminal environment variable
(( $+commands[alacritty] )) && export TERMINAL="alacritty"

# Lesspipe
(( $+commands[lesspipe.sh] )) && eval "$(lesspipe.sh)"

# Bat settings
if (( $+commands[bat] )); then
	export BAT_THEME="ansi"
	export BAT_STYLE="auto"
fi
# }}}

# Aliases {{{

# Basic commands
alias -- -="cd -"
alias diff="diff --color"
alias grep="grep --color"
alias ip="ip --color"
alias info="info --vi-keys"
alias g=git
alias v="$EDITOR"
if (( $+commands[nvim] )); then
	alias vimdiff="nvim -d"
fi
if (( $+commands[kubectl] )); then
	alias k=kubectl
fi

# Ls aliases
alias ls="ls --human-readable --color=never"
alias l="ls -l"
alias la="ls -l --all"
alias lr="ls -l --recursive"
alias lx="ls -l --all --inode --size"

# Extra man pager using $EDITOR
alias vman="MANPAGER='$EDITOR_MANPAGER' man"

# Zsh configuration and reload
alias zshsource="source $HOME/.zshrc && echo 'sourced zshrc'"
alias zshconfig="$EDITOR $HOME/.zshrc && zshsource"

# Git configuration
alias gitconfig="git config --global --edit"

# i3/sway configuration and reload
if (( $+commands[i3] )); then
	alias i3source="i3-msg restart"
	alias i3config="$EDITOR $HOME/.config/i3/config && i3source"
fi
if (( $+commands[sway] )); then
	alias swaysource="swaymsg reload"
	alias swayconfig="$EDITOR $HOME/.config/sway/config && swaysource"
fi
# }}}

# Autoloads and evals {{{

# Set LS_COLORS
eval "$(dircolors)"

# Colors
autoload -U colors && colors

# Renamer ($ zmv '(*)_(*)_(*)' '$3_$2_$1' # foo_bar_baz -> baz_bar_foo)
autoload -Uz zmv

# Add hooks to zsh
autoload -Uz add-zsh-hook

# }}}

# Prompt {{{
setopt PROMPT_SUBST

autoload -Uz vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' formats '%c%u%b'
zstyle ':vcs_info:*' actionformats '%c%u%b(%a)'

# Asyncronous git status fetch {{{
# https://vincent.bernat.ch/en/blog/2019-zsh-async-vcs-info
_vbe_vcs_async_start() {
	async_start_worker vcs_info
	async_register_callback vcs_info _vbe_vcs_info_done
}
_vbe_vcs_info() {
	cd $1
	vcs_info
	print ${vcs_info_msg_0_}
}
_vbe_vcs_info_done() {
	local job=$1
	local return_code=$2
	local stdout=$3
	local more=$6
	if [[ $job == "[async]" ]]; then
		if [[ $return_code -eq 2 ]]; then
			# Need to restart the worker. Stolen from
			# https://github.com/mengelbrecht/slimline/blob/master/lib/async.zsh
			_vbe_vcs_async_start
			return
		fi
	fi
	vcs_info_msg_0_=$stdout
	(( $more )) || zle reset-prompt
}
_vbe_vcs_chpwd() {
	vcs_info_msg_0_=
}
_vbe_vcs_precmd() {
	async_flush_jobs vcs_info
	async_job vcs_info _vbe_vcs_info $PWD
}

async_init
_vbe_vcs_async_start
add-zsh-hook precmd _vbe_vcs_precmd
add-zsh-hook chpwd _vbe_vcs_chpwd
# }}}

# Prompt auxiliary variables
# (Note: replace %# with %(!.#.$) for bash-like prompt)
local NEWLINE=$'\n'
local PROMPT_GIT_INFO='${vcs_info_msg_0_:-""}'
local PROMPT_ERROR_HANDLING="%(?..%F{9}%?%f )"

local PROMPT_SELECTOR=3
case "$PROMPT_SELECTOR" in
	1)
		local PROMPT_INFO="%n@%m:%~%#"
		;;
	2)
		local PROMPT_INFO="%m%S%n%s%1~ %#"
		;;
	3)
		local PROMPT_INFO="%F{10}%n@%m%f:%F{12}%~%f%#"
		local PROMPT_GIT_INFO="%F{13}${PROMPT_GIT_INFO}%f"
		;;
esac

export PROMPT="${PROMPT_ERROR_HANDLING}${PROMPT_INFO} "
export RPROMPT="${PROMPT_GIT_INFO}"
# }}}

# Options {{{

# Miscellaneous
setopt HASH_LIST_ALL
setopt LONG_LIST_JOBS
setopt NO_BEEP
setopt NO_GLOB_DOTS
setopt NO_HUP
setopt NO_SH_WORD_SPLIT
setopt NOTIFY
setopt NO_NOMATCH

# Command history
HISTFILE="$HOME/.zhistory"
HISTSIZE=1000000
SAVEHIST=1000000
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# }}}

# Completion {{{
zmodload zsh/complist

# Vi mode for selecting completion
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "l" vi-forward-char

autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
_comp_options+=(globdots)

setopt ALWAYS_TO_END
setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD
setopt EXTENDED_GLOB
setopt GLOB_COMPLETE
setopt LIST_TYPES
unsetopt FLOW_CONTROL

# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' add-space true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' completer _expand _complete _ignored _expand_alias _extensions _match _correct _approximate _prefix
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '-- %d --'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' group-order aliases functions builtins commands
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-prompt "%SAt %p: Hit TAB for more, or the character to insert%s"
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/2))numeric)'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt "%SScrolling active: current selection at %p%s"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true

zstyle ':completion:*:*:*:*:corrections' format '-- %d (errors: %e) --'
zstyle ':completion:*:*:*:*:descriptions' format '-- %d --'
zstyle ':completion:*:*:*:*:messages' format '-- %d --'
zstyle ':completion:*:*:*:*:warnings' format '-- no matches found --'
# }}}

# Autojump {{{
# (if zoxide is not installed, this is a good fallback)
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*' recent-dirs-insert always
zstyle ':chpwd:*' recent-dirs-max 100000
# }}}

# Keybinds {{{
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
autoload -Uz edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

# Suppress delay on Esc key
KEYTIMEOUT=1

# Set vi-mode in Zsh
bindkey -v

# Shift + Tab to reverse cycling order on completion
bindkey "^[[Z" reverse-menu-complete

# Delete characters with Delete and Backspace, respectively
bindkey "^[[3~" delete-char
bindkey "^?" backward-delete-char
bindkey "^H" backward-kill-word

# Alt + . to insert last word, as in Emacs mode
bindkey "\e." insert-last-word

# Ctrl-e to edit command line in $EDITOR
bindkey "^E" edit-command-line
bindkey -M vicmd "^E" edit-command-line

# Ctrl-r (or / in normal mode of vi-mode) to search commands
bindkey "^R" history-incremental-search-backward
bindkey -M vicmd "/" history-incremental-search-backward

# Up/Down, Ctrl-p/n, k/j to go up and down while completing partial command
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Add text objects to command line
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
	for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
		bindkey -M $km -- $c select-quoted
	done
	for c in {a,i}${(s..)^:-"()[]{}<>bB"}; do
		bindkey -M $km -- $c select-bracketed
	done
done

# Turn ... into ../..
function rationalize-dot {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N rationalize-dot
bindkey . rationalize-dot
# }}}

# Functions {{{
if (( $+commands[xdg-open] && $+commands[fzf] )) ; then
	function open() {
		if [[ $# -ne 0 ]]; then
			for arg in "$@"; do
				(xdg-open "$PWD/$arg" > /dev/null 2>&1 &)
			done
		else
			(fzf --multi | xargs -I {} sh -c "xdg-open '$PWD/{}' > /dev/null 2>&1 &")
		fi
	}
fi

if (( $+commands[pgrep] )); then
	function psgrep() {
		if [[ $# -eq 0 ]]; then
			echo "Usage: psgrep <pattern>"
			return 1
		fi
		local pattern="$1"
		pgrep "$pattern" > /dev/null && ps u $(pgrep "$pattern")
	}
fi
# }}}

# Fzf {{{
if (( $+commands[fzf] )); then
	if $(fzf --zsh > /dev/null 2>&1); then
		eval "$(fzf --zsh)"
	else
		source "$(fzf-share)/key-bindings.zsh"
		source "$(fzf-share)/completion.zsh"
	fi

	# Stop fzf completion trigger from colliding with zsh glob operator
	export FZF_COMPLETION_TRIGGER=",,"

	# Fzf options
	local fzf_options=(
		"--height 30%"
		"--layout reverse"
		"--info inline"
		"--multi"
		"--bind '?:toggle-preview,ctrl-a:toggle-all'"
		"--preview-window 'right,50%,<50(up,50%)'"
		"--color 16"
	)

	# Variables and functions for fzf operation
	export FZF_DEFAULT_OPTS="${fzf_options[@]}"

	if (( $+commands[fd] )); then
		local FD_DEFAULT_OPTS=(
			--hidden
			--no-ignore
			--exclude ".git"
			--exclude ".hg"
			--exclude ".svn"
			--exclude "CVS"
		)

		export FZF_DEFAULT_COMMAND="fd --type f $FD_DEFAULT_OPTS"
		export FZF_CTRL_T_COMMAND="fd --type f $FD_DEFAULT_OPTS"
		export FZF_ALT_C_COMMAND="fd --type d $FD_DEFAULT_OPTS"

		_fzf_compgen_path() {
			fd $FD_DEFAULT_OPTS . "$1"
		}

		_fzf_compgen_dir() {
			fd --type d $FD_DEFAULT_OPTS . "$1"
		}
	fi
fi
# }}}

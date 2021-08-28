# Aliases {{{

# Basic commands
alias ..="cd .."
alias -- -="cd -"
alias cp="cp -r"
alias mkdir="mkdir -p"
alias wget="wget -c"
alias ip="ip --color=auto"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias t=tmux
alias v=vim

# Ls aliases
alias lt="tree -L 2"
alias ls="ls -CFN" # --color=auto"
alias lsa="ls -A"
alias l="ls -lh"
alias la="ls -lhA"
alias lx="ls -lisah"
alias lr="ls -lhR"
alias lrs="ls -R"
alias lra="ls -lhAR"

# Ssh with xterm, for targets without alacritty
alias ssh="TERM=xterm-256color ssh"

# Search for processes
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

# }}}

# Prompt {{{
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' formats '[%s:%b%m%u%c]'
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
NEWLINE=$'\n'
PROMPT='%m%S%n%s%1~${vcs_info_msg_0_}%(?..%F{red}[%?]%f) '
#PROMPT='%m%S%n%s%1~${vcs_info_msg_0_}[%D{%H:%M:%S}]%(?..%F{red}[%?]%f) '
#PROMPT='[%n@%m %1~]${vcs_info_msg_0_}%(?..%F{red}[%?]%f)$ '
#PROMPT='[%n@%m %1~]${vcs_info_msg_0_}[%D{%H:%M:%S}]%(?..%F{red}[%?]%f)$ '
#PROMPT='┌[%~]${vcs_info_msg_0_}%(?..%F{red}[%?]%f)${NEWLINE}└[%n@%m]: '
#PROMPT='┌[%~]${vcs_info_msg_0_}[%D{%H:%M:%S}]%(?..%F{red}[%?]%f)${NEWLINE}└[%n@%m]: '
#PROMPT='%B%F{blue}%n%f%b at %B%F{green}%m%f%b in %B%F{yellow}[%~]%f%b on %B%F{magenta}${vcs_info_msg_0_}%f%b${NEWLINE}%(?..%F{red})%B%D{%H:%M:%S}%f $%b '
# }}}

# Directory stack {{{
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# }}}

# Completion menu {{{
setopt always_to_end
setopt auto_menu
setopt complete_in_word
setopt flow_control
setopt autocd
#eval "$(dircolors)"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:*' menu yes select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zsh/zcompcache"
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# }}}

# Command history {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history
setopt share_history
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
# }}}

# Vi-mode {{{
bindkey -v
KEYTIMEOUT=1
bindkey "^[[Z" reverse-menu-complete
bindkey "^[[3~" delete-char
bindkey "^?" backward-delete-char
bindkey "\e." insert-last-word
# }}}

# Variables {{{
export MANPAGER="nvim +Man!"
export EDITOR=vim
export VISUAL=vim
# }}}

## Specifics from my main machine

# Mudar em cada semestre; info tecnico dos amiguinhos
#alias turnos="cat /home/filipelsilva/OneDrive/2º\ Ano/1º\ Semestre/Calendários/Horário/turnos.exe.txt"
#alias horario="open /home/filipelsilva/OneDrive/2º\ Ano/1º\ Semestre/Calendários/Horário/horario.png"
#alias links="cat /home/filipelsilva/OneDrive/2º\ Ano/1º\ Semestre/Calendários/Horário/Horário.txt"

# Deemix
#alias deemix="python3 /home/filipelsilva/Transferências/Programs/deemix/server.py"

# Change between intel and nvidia graphics card
#alias intel="sudo prime-select intel && reboot"
#alias nvidia="sudo prime-select nvidia && reboot"
##

# Para pesquisa
alias fd=fdfind

# Open folders/files as if you were in the file manager
alias open="xdg-open"

# Basic commands
alias cp="cp -r"
alias mv="mv"
alias mkdir="mkdir -p"

# See all processes
alias psa="ps aux"

# Grep for one process
function psgrep() {
  ps aux | grep $1
}

# Aliases for tmux
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"
alias tp="tmuxp"

# Nvim to vim transition
alias vim="nvim -p"
alias oldvim="\vim"

# Git quality of life improvement
alias gtree="git log --graph --all"

# Funcao para arranjar links de um website e sacar tudo para a pasta
function linkdump() {
  lynx -dump -listonly -nonumbers $1 | grep .pdf > dump.txt
  wget -i dump.txt
  rm dump.txt
}

## Fzf
# Make fzf not collide with zsh
export FZF_COMPLETION_TRIGGER='++'

export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--bind '?:toggle-preview'
"

# Fzf using fd instead of find
export FZF_DEFAULT_COMMAND="fdfind --hidden --follow --exclude '.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

_fzf_compgen_path() {
  fdfind . "$1"
}
_fzf_compgen_dir() {
  fdfind --type d . "$1"
}

# find-in-file - usage: fif <SEARCH_TERM>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}
##

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Theme
#ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
  zsh-autosuggestions
  zsh-aliases-exa
  fast-syntax-highlighting
  z
  fzf
  colored-man-pages
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Zoxide integration 
eval "$(zoxide init zsh)"

# TheFuck integration
eval $(thefuck --alias)

# GitHub CLI integration
eval "$(gh completion -s zsh)"

# Tmuxp integration
eval "$(_TMUXP_COMPLETE=source_zsh tmuxp)"
export DISABLE_AUTO_TITLE='true'

# Tmux color for zsh suggestions 
export TERM=xterm-256color

# Starship
eval "$(starship init zsh)"

source /home/$USER/.config/forgit/forgit.plugin.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

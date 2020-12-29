PROMPT='%{$fg[yellow]%}[%n@%m]%{$fg[blue]%}[%2~]$(git_prompt_info)%{$reset_color%} '
RPROMPT='%{$reset_color%}%(?..%{$fg[red]%}[ERR:%?])%{$fg[yellow]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%B%{$fg[cyan]%}[%n@%m]%{$fg[yellow]%}[%2~]$(git_prompt_info)%b%{$reset_color%} '
RPROMPT='%{$reset_color%}%B%(?..%{$fg[red]%}[ERR:%?])%{$fg[cyan]%}[%*]%b%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

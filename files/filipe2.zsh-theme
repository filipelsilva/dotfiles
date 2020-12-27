PROMPT='%{$fg[magenta]%}[%n@%m]%{$fg[red]%}[%2~]$(git_prompt_info)%{$reset_color%} '
RPROMPT='%{$reset_color%}%(?..%{$fg[red]%}[ERR:%?])%{$fg[magenta]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%B%{$fg[magenta]%}%n@%m/%{$fg[blue]%}%1~%{$fg[cyan]%}/$(git_prompt_info)%b%{$reset_color%} '
RPROMPT='%{$reset_color%}%B%(?..%{$fg[red]%}ERR:%?|)%{$fg[magenta]%}%*%b%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="/%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

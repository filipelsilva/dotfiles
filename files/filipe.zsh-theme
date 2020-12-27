PROMPT='%{$fg[magenta]%}%n@%m/%{$fg[red]%}%2~%{$fg[cyan]%}/$(git_prompt_info)%{$reset_color%} '
RPROMPT='%{$reset_color%}%{$fg[magenta]%}%*%(?..|%{$fg[red]%}ERR:%?)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="/%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

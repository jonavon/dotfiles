local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m %{$reset_color%}'
    local primary_symbol='#'
    local secondary_symbol="."
else
    local user_host='%{$fg[green]%}%n@%m %{$reset_color%}'
    local primary_symbol='%{$fg[blue]%}▸%{$reset_color%}'
    local secondary_symbol="%{${fg[blue]%}▹%{$reset_color%}"
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%(4~|%-1~/.../%2~|%3~) %{$reset_color%}'
local git_branch='%{$terminfo[bold]$fg[magenta]%}$(git_prompt_info)%{$reset_color%}'
local venv_prompt='$(virtualenv_prompt_info)'

PROMPT="${user_host}${venv_prompt}${current_dir}${git_branch}
%B${primary_symbol}%b "
RPROMPT="%B${return_code}%b"

PROMPT2="%B${secondary_symbol}%b "

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "

ZSH_THEME_CONDA_ENV_PREFIX="%{$terminfo[bold]$fg[yellow]%}ᶜ["
ZSH_THEME_CONDA_ENV_SUFFIX="] %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$terminfo[bold]$fg[yellow]%}["
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="] %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX
ZSH_THEME_VIRTUALENV_SUFFIX=$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX

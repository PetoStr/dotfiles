[ -f ~/.config/aliasrc ] && source ~/.config/aliasrc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTFILE=~/.cache/zsh/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt hist_ignore_all_dups

setopt completealiases
setopt globdots
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select

unsetopt beep
ttyctl -f

autoload -Uz compinit
compinit

bindkey -v '^?' backward-delete-char

autoload -U colors && colors
PROMPT="%B%{$fg[black]%}[%{$fg[green]%}%n@%M %{$fg[red]%}%~%{$fg[black]%}]%{$fg[blue]%}$%{$reset_color%} "

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


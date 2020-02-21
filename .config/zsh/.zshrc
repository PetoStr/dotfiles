[ -f ~/.config/aliasrc ] && source ~/.config/aliasrc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000000
setopt appendhistory
setopt HIST_IGNORE_DUPS

setopt completealiases
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


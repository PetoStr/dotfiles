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

# Remove mode switching delay.
KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

function zle-line-init {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}

autoload -U colors && colors
PROMPT="%B%{$fg[black]%}[%{$fg[green]%}%n@%M %{$fg[red]%}%~%{$fg[black]%}]%{$fg[blue]%}$%{$reset_color%} "

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

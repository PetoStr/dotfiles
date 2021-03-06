#!/usr/bin/env sh

export TERMINAL="st"
export EDITOR="nvim"

export LESSHISTFILE=-
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export PATH="$HOME/.local/bin:$PATH"
export ZDOTDIR="$HOME/.config/zsh"

[[ -z "$DISPLAY" ]] && [[ "$(fgconsole)" -eq 1 ]] && exec startx

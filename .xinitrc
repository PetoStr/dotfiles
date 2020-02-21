#!/bin/sh

wal -R

compton -b --config "$HOME/.config/compton/compton.conf" &

xset r rate 215 40

setxkbmap -layout us,sk
setxkbmap -option 'grp:win_space_toggle'

setxkbmap -option caps:super
xcape -e 'Super_L=Escape'

light -S 75

start-pulseaudio-x11 &
blugon &
exec i3


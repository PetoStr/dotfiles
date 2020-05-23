#!/bin/sh

wal -R

picom -b

xset r rate 200 50

setxkbmap -layout us,sk
setxkbmap -option 'grp:win_space_toggle'

setxkbmap -option caps:super
xcape -e 'Super_L=Escape'

light -S 75

start-pulseaudio-x11 &
blugon &
exec i3

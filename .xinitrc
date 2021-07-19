#!/bin/sh

picom -b

kb-config

light -S 33

start-pulseaudio-x11 & # big hopes for chromium
feh-bg & # custom script to set wallpaper with feh
x-on-resize --config ~/.local/bin/on-resize &
blugon &
dwmblocks &
exec dwm

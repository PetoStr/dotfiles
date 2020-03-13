#!/usr/bin/env zsh

set -eu

# cd to script's location
cd "$(dirname "$0")"
dotfilesdir="$(pwd)"

scriptname="$(basename "$0")"

dirs="$HOME/.config/i3
$HOME/.config/polybar
$HOME/.config/i3
$HOME/.config/polybar
$HOME/.config/fontconfig
$HOME/.config/compton
$HOME/.config/zsh
$HOME/.config/sxiv/exec
$HOME/.local/bin
$HOME/.vim/file_templates
$HOME/Pictures/prntscr"

bckdir="$HOME/dotfiles-bck-$(date '+%d-%m-%y_%H-%M-%s')"

createdirs () {
	for dir in "${(f)dirs}"; do
		mkdir -vp "$dir"
	done
}

symlinkdotfiles () {
	find . -type f -not -path "./.git/*" | while read -r file; do
		case $file in
			"./$scriptname"|./*.md)
				continue
				;;
			*)
				file="$(echo "$file" | cut -c3-)"
				if [ -e "$HOME/$file" ]; then
					mkdir -vp "$bckdir"
					cp -r --parent "$HOME/$file" "$bckdir"
				fi
				ln -svf "$dotfilesdir/$file" "$HOME/$file"
				;;
		esac
	done
}

createdirs
symlinkdotfiles

echo "Done."


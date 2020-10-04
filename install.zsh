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
$HOME/.config/nvim
$HOME/.local/bin
$HOME/.local/share/file_templates
$HOME/pics/prntscr
$HOME/.cache/zsh"

bckdir="$HOME/dotfiles-bck-$(date '+%y-%m-%d_%H-%M-%S')"

createdirs () {
	echo "Preparing directories."
	for dir in "${(f)dirs}"; do
		mkdir -vp "$dir"
	done
}

symlinkdotfiles () {
	echo "Linking dotfiles."
	find . -type f -not -path "./.git/*" | while read -r file; do
		case $file in
			"./$scriptname"|./*.md)
				continue
				;;
			*)
				file="$(echo "$file" | cut -c3-)"
				if ! [ -L "$HOME/$file" ]; then
					echo
					echo "$HOME/$file exists, making a backup"
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

#!/usr/bin/env sh

set -eu

# cd to script's location
cd "$(dirname "$0")"
dotfilesdir="$(pwd)"

createdirs() {
	mkdir -vp "$HOME/.config/i3"
	mkdir -vp "$HOME/.config/polybar"
	mkdir -vp "$HOME/.config/fontconfig"
	mkdir -vp "$HOME/.config/compton"
	mkdir -vp "$HOME/.config/zsh"
	mkdir -vp "$HOME/.config/sxiv/exec"

	mkdir -vp "$HOME/.local/bin"
	mkdir -vp "$HOME/.vim/file_templates"

	mkdir -vp "$HOME/Pictures/prntscr"
}

symlinkdotfiles () {
	find . -type f -not -path "./.git/*" | while read -r file; do
		case $file in
			"./$(basename "$0")"|./*.md)
				continue
				;;
			*)
				file="$(echo "$file" | cut -c3-)"
				ln -svf "$dotfilesdir/$file" "$HOME/$file"
				;;
		esac
	done
}

createdirs
symlinkdotfiles

echo "Done."


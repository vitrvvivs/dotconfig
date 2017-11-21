#!/bin/sh
git-ignore() {
	topdir="$(git rev-parse --show-toplevel)"
	target=$(pwd)/$*
	[ -e "$1" ] 2>/dev/null && target=$(realpath "$*")
	echo "$target" | sed "s;$topdir;;g" >> "$topdir/.gitignore"
}
alias gitignore=git-ignore
alias gi=git-ignore

git-commit-push() {
	git commit -am "$*" && git push origin "$(git rev-parse --abbrev-ref HEAD)"
}
alias gcp=git-commit-push

function git-ignore() {
	topdir="$(git rev-parse --show-toplevel)"
	target=$(pwd)/$*
	[ -e $1 ] 2>/dev/null && target=$(realpath $*)
	echo "$(echo $target | sed "s;$topdir;;g")" >> "$topdir/.gitignore"
}
alias gitignore=git-ignore
alias gi=git-ignore

function git-commit-push {
	eval "git commit -am \"$@\"" && git push origin $(git rev-parse --abbrev-ref HEAD)
}
alias gcp=git-commit-push

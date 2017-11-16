function git-ignore() {
	topdir="$(git rev-parse --show-toplevel)"
	target=$(pwd)/$*
	if [ -e $1 ] 2>/dev/null && target=$(realpath $*)
	echo "$(echo $target | sed "s;$topdir;;g")" >> "$topdir/.gitignore"
}

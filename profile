# run once at login, regardless of X or TTY
export PYTHONPATH="$HOME/.config/pythonlib"
export PATH="$HOME/bin:$HOME/.config/bin:$PATH"

if [ -z $DISPLAY ]; then
	setterm -term linux -blength 0
else
	xset -b
fi

#eval `ssh-agent` && ssh-add
#[[ ! -s "~/.config/mpd/pid" ]] && "$HOME/.config/bin/mpd" &
[[ "$(tty)" == "/dev/tty1" ]] && startx &

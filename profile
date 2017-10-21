# run some configuration commands
if [ -z $DISPLAY ]; then
	setterm -term linux -blength 0
else
	xset -b
fi

[ ! -s ~/.config/mpd/pid ] && $HOME/bin/mpd &

[ $(tty) = "/dev/tty1" ] && startx &

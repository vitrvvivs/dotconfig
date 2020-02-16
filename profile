# run some configuration commands
export PYTHONPATH="$HOME/.config/pythonlib"
export PATH="$HOME/bin:$PATH"
export DOCKER_HOST="unix:///var/run/docker.sock"

if [ -z $DISPLAY ]; then
	setterm -term linux -blength 0
else
	xset -b
fi

eval `ssh-agent` && ssh-add

[ ! -s ~/.config/mpd/pid ] && $HOME/bin/mpd &
[ $(tty) = "/dev/tty1" ] && startx &

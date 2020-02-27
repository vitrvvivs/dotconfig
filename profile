# vim: set ft=sh:
# this file is run once at login by all shells, regardless of X or TTY

# We don't want to keep prepending to $PATH's, so these are here
export GOPATH="$HOME/.go:$GOPATH"
export PYTHONPATH="$HOME/.config/pythonlib:$PYTHONPATH"
export PATH="$HOME/bin:$HOME/.config/bin:$PATH"

# Mute the bell
setterm -term linux -blength 0

#eval `ssh-agent` && ssh-add
#[[ ! -s "~/.config/mpd/pid" ]] && "$HOME/.config/bin/mpd" &
if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then 
    startx &
fi

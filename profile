# vim: set ft=sh:
# this file is run once at login by all shells, regardless of X or TTY

# We don't want to keep prepending to $PATH's, so these are here
export GOPATH="$HOME/.go:$GOPATH"
export PYTHONPATH="$HOME/.config/pythonlib:$PYTHONPATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.config/bin:$HOME/.cargo/bin:$HOME/.config/yarn/global/node_modules/.bin/:$PYENV_ROOT/bin:$GOPATH/bin:$PATH"

export OPS_WORKDIR="$HOME/work/private-ops"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

eval "$(pyenv init --path)"
eval $(ssh-agent)
ssh-add "$HOME/.ssh/id_rsa"

# Mute the bell
setterm -term linux -blength 0

#eval `ssh-agent` && ssh-add
#[[ ! -s "~/.config/mpd/pid" ]] && "$HOME/.config/bin/mpd" &
if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then 
    startx &
fi

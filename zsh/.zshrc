# Set Globals
source "$HOME/.env"
ADOTDIR="$ZDOTDIR/antigen"
source "$ADOTDIR/antigen.zsh"

# Configure ZSH itself
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
HYPHEN_INSENSITIVE="true"

unsetopt autocd
setopt extended_glob

autoload -Uz compinit promptinit
compinit
promptinit


# Key Commands
export KEYTIMEOUT=1
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

# tty
bindkey "[1~"		beginning-of-line
bindkey "[4~"		end-of-line
bindkey "[3~"		delete-char


# Aliases
alias ls='ls --color=tty'
alias lsblk="lsblk --output NAME,SIZE,LABEL,FSTYPE,UUID"
alias nw="urxvt &"

# Pass settings on to oh-my-zsh
ANTIGEN_CACHE_DIR=$ZDOTDIR/.cache/init.zsh

## Antigen
# Plugins
antigen bundle git
antigen bundle vi-mode
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Theme
POWERLEVEL9K_MODE='powerline'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv virtualenv aws vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs vi_mode)

# Theme on tty
if [[ $(tty) == /dev/tty* ]]; then
	setfont /usr/share/kbd/consolefonts/ter-powerline-v14n.psf.gz
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=($POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS time battery)
	POWERLEVEL9K_BATTERY_ICON="B" # fucks up location of first character when an icon is double width in definition (default), but single width in practice (i.e. placeholder char)
fi

antigen theme "$ZDOTDIR/themes/powerlevel9k"
antigen apply

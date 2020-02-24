# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Import
[[ -e "$HOME/.env" ]] && source "$HOME/.env"

# Load plugins
function recompile-plugins() { antibody bundle < "$ZDOTDIR/.zsh_plugins" > "$ZDOTDIR/.zsh_plugins.sh"; }
[[ -e "$ZDOTDIR/.zsh_plugins.sh" ]] || recompile-plugins
source "$ZDOTDIR/.zsh_plugins.sh"

# ZSH itself
HISTFILE=~/.bash_history
HISTSIZE=10000
SAVEHIST=10000
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
HYPHEN_INSENSITIVE="true"

# Syntax Highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

unsetopt autocd
setopt extended_glob

autoload -Uz compinit promptinit vsc_info zmv
compinit
promptinit

# Theme
# Colors
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='↑'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='↓'
## Theme on tty
#if [[ $(tty) == /dev/tty* ]]; then
#	setfont /usr/share/kbd/consolefonts/ter-powerline-v14n.psf.gz
#	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=($POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS time battery)
#	POWERLEVEL9K_BATTERY_ICON="B" # fucks up location of first character when an icon is double width in definition (default power icon), but single width in practice (placeholder char)
#	POWERLEVEL9K_HOME_ICON="H"
#fi
## vcs is hella slow on sshfs; quick way to disable it
function disable-realtime-extensions() { 
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS[(i)vcs]=();
	ZSH_HIGHLIGHT_HIGHLIGHTERS=()
}
function enable-vcs-realtime-extensions() { 
	disable-realtime-extensions;
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=(vcs);
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
}

# Key Commands
export KEYTIMEOUT=1
bindkey -M vicmd '/' zaw-history
bindkey -M vicmd '?' zaw-history
bindkey -M viins '^R' zaw-history
bindkey -M viins '^F' zaw-history
#bindkey -M filterselect '^R' down-line-or-history
#bindkey -M filterselect '^F' up-line-or-history
#bindkey -M filterselect '' send-break
bindkey '' autosuggest-execute

# tty
bindkey "[1~"		beginning-of-line
bindkey "[4~"		end-of-line
bindkey "[3~"		delete-char

# zaw-history
zstyle ':filter-select:highlight' matched fg=green,bold
zstyle ':filter-select' max-lines 20 # use 10 lines for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
zstyle ':filter-select' extended-search yes # see below
zstyle ':filter-select' hist-find-no-dups yes # ignore duplicates in history source

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

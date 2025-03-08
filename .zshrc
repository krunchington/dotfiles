autoload -U colors && colors
source ~/.zshrc.custom

export PATH="$PATH:/opt/nvim-linux64/bin"

export EDITOR='nvim'
export GIT_EDITOR='nvim'

# history stuff
export HISTFILE=~/.zsh_history
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.


alias ls="ls --color=auto"
alias tree="tree --gitignore"

setopt PROMPT_SUBST

C_30='%{'$(print -P '\e[0;30m')'%}'
C_31='%{'$(print -P '\e[0;31m')'%}'
C_32='%{'$(print -P '\e[0;32m')'%}'
C_33='%{'$(print -P '\e[0;33m')'%}'
C_34='%{'$(print -P '\e[0;34m')'%}'
C_35='%{'$(print -P '\e[0;35m')'%}'
C_36='%{'$(print -P '\e[0;36m')'%}'
C_37='%{'$(print -P '\e[0;37m')'%}'
NORM='%{'$(print -P '\e[0m')'%}'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '[%b] '

export PS1='${C_31}%* ${C_35}%2~ ${C_36}${vcs_info_msg_0_}${C_32}▶▸ ${NORM}'

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

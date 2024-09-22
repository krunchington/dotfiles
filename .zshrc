autoload -U colors && colors
autoload -Uz vcs_info

export PATH="$PATH:/opt/nvim-linux64/bin"


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

# configure git info in shell prompt
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# vcs prompt info should be just the branch name
zstyle ':vcs_info:git:*' formats '%b'

# prompt configs
# RPROMPT='${vcs_info_msg_0_}'

C_30='%{'$(print -P '\e[0;30m')'%}'
C_31='%{'$(print -P '\e[0;31m')'%}'
C_32='%{'$(print -P '\e[0;32m')'%}'
C_33='%{'$(print -P '\e[0;33m')'%}'
C_34='%{'$(print -P '\e[0;34m')'%}'
C_35='%{'$(print -P '\e[0;35m')'%}'
C_36='%{'$(print -P '\e[0;36m')'%}'
C_37='%{'$(print -P '\e[0;37m')'%}'
NORM='%{'$(print -P '\e[0m')'%}'
# PROMPT="${C_31}%* %n@%m ${C_35}%2~ ${C_32}▶▸ ${NORM}"
PROMPT="${C_31}%* ${C_35}%2~ ${C_32}▶▸ ${NORM}"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

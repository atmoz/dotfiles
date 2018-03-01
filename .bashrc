#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.bash_colors

alias ls='ls --color=auto'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#####################################################################
## GPG
#####################################################################

# Set GPG TTY
export GPG_TTY=$(tty)

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

#####################################################################

export EDITOR="vim"

export LC_ALL=en_US.UTF-8
export LANG="$LC_ALL"

export PATH=$PATH:~/bin

#export GOPATH=~/workspace/go
#export PATH=$PATH:$GOPATH/bin

export HISTCONTROL=ignoreboth:erasedups

export ATMOZ_GPG_ID=0xB9FB68F98F88BA47

# junit
#JUNIT_HOME=/usr/share/java
#export CLASSPATH=.:./target/classes:$JUNIT_HOME/junit.jar:$JUNIT_HOME/hamcrest-core.jar:/home/atmoz/workspace/study/INF102/algs4.jar

#####################################################################
## Prompt command
#####################################################################

export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWSTASHSTATE=true
source /usr/share/git/completion/git-prompt.sh

function __ps1_date {
    dateString="$(date +"[%T]") "
    clr_white -n "$dateString"
}

function __terminalTitle() {
    echo -ne "\033]0;$PWD\007"
}

ps1pc_start="\n"
ps1pc_end='$(clr_bold clr_blue -n "\w")$(if [ ! \j == 0 ]; then clr_bold clr_brown -n " (\j)"; fi) $(clr_bold "\$") '
PROMPT_COMMAND='__git_ps1 "$ps1pc_start" "$ps1pc_end" "%s\n" && __terminalTitle'

#####################################################################

function cal() {
    if [ $# == 0 ]; then
        /usr/bin/cal -my --week
    else
        /usr/bin/cal $@
    fi
}

function dup() {
    newTerm="sakura"
    ($newTerm &) 2> /dev/null
}

# Wine magic
alias wine32="WINEPREFIX='/home/atmoz/.wine32'"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles status --short # show if any changes are uncommited

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='[\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#####################################################################
# start GPG
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
# end GPG
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
# start prompt command
#####################################################################

function __color() {
    echo "\[\e[${1}m\]${@:2}\[\e[m\]"
}

#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
source /usr/share/git/completion/git-prompt.sh

function __ps1_newline_login {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true

    gitPsInfo='$(__git_ps1  "[%s] ")'
    PS1="${PS1/\$/$gitPsInfo\$}"
  else
    #printf '\n'
    #line=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' '  '-')
    line="\n"
    dateString="" # " $(date +"%F %T")"
    printf '\e[0;37m'
    printf -- "${line:${#dateString}}${dateString}"
    printf '\e[0m'
  fi
}

function __terminalTitle() {
    title="${PWD/#\/home\/atmoz/\~}"
    echo -ne "\033]0;$title\007"
}

#ps1pc_start="$(__color $dblue '\w')"
#ps1pc_end='$(if [ ! \j == 0 ]; then echo " \[\e[1;31m\](\j)\[\e[m\]"; fi) \$ '
#PROMPT_COMMAND='__ps1_newline_login && __git_ps1 "$ps1pc_start" "$ps1pc_end" ":%s" && __terminalTitle'

#####################################################################
# end prompt command
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

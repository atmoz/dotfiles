#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#####################################################################

alias ls='ls --color=auto'
alias r=ranger
alias kicat="kitty +kitten icat"
alias kdiff="kitty +kitten diff"

alias py=python3

alias termbin="nc termbin.com 9999"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export TERMINAL="kitty"
export EDITOR="vim"

export LC_ALL=en_US.UTF-8
export LANG="$LC_ALL"

export PATH=$PATH:~/bin:~/.local/bin

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export HISTCONTROL=ignoreboth:erasedups

# junit
#JUNIT_HOME=/usr/share/java
#export CLASSPATH=.:./target/classes:$JUNIT_HOME/junit.jar:$JUNIT_HOME/hamcrest-core.jar:/home/atmoz/workspace/study/INF102/algs4.jar

#####################################################################
## GPG
#####################################################################

export ATMOZ_GPG_ID=0xB9FB68F98F88BA47

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
## Prompt command
#####################################################################

export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWSTASHSTATE=true
source /usr/share/git/completion/git-prompt.sh

function __terminalTitle() {
    echo -ne "\033]0;$PWD\007"
}

BLUE='\[\033[1;34m\]'
WHITE='\[\033[1;37m\]'
RESET='\[\033[0m\]'

lf_indicator="${LF_LEVEL:+"lf($LF_LEVEL)"}"
ps1pc_start="\n"
ps1pc_end="$BLUE\w$WHITE"'$(if [ ! \j == 0 ]; then echo " (\j)"; fi) \$'"$RESET "

if [ -f /run/.containerenv ]; then
    container_name="$(sed -nE 's/name="(.*)"/\1/p' /run/.containerenv)"
    PROMPT_COMMAND='__git_ps1 "${ps1pc_start}[$container_name] " "$lf_indicator \n$ps1pc_end" "%s " && __terminalTitle'
else
    PROMPT_COMMAND='__git_ps1 "$ps1pc_start" "$lf_indicator \n$ps1pc_end" "%s " && __terminalTitle'
fi

#####################################################################
## Helper functions
#####################################################################

function cal() {
    if [ $# == 0 ]; then
        /usr/bin/cal -my --week
    else
        /usr/bin/cal "$@"
    fi
}

function dup() {
    ($TERMINAL &) 2> /dev/null
}

function cdtemp() {
    cd "$(mktemp -d)"
}

# https://github.com/gokcehan/lf/blob/7d47436a352eb7f7d61303045ed79ed8989c6270/etc/lfcd.sh
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

function cdgit() {
    cd "$(~/bin/fzfgit "$*")" || exit 1
}


#####################################################################
## Version controlled configurations
#####################################################################

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Remind me of uncommitted changes
if [ "$PWD" == "$HOME" ]; then
    dotfiles status --short -uno
    git -C ~/bin status --short -uno
    git -C /srv/formulas/workstation-formula status --short -uno
fi

source <(kitty + complete setup bash)

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

# Print color palette
for i in {0..15}; do
    echo -en "\033[48;5;${i}m $(printf "%2s" "$i") \033[0m";
    [ "$i" -eq 7 ] && echo
done
echo; echo

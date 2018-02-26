#
# ~/.bash_profile
#

# User xdg dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# System xdg dirs
export XDG_DATA_DIRS=/usr/local/share:/usr/share:/var/lib/flatpak/exports/share
export XDG_CONFIG_DIRS=/etc/xdg

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    echo "Starting Xorg ..."
    #exec startx >/dev/null 2>&1
    exec startx -- vt1 &> /dev/null
fi

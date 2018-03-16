# Setup fzf
# ---------
if [[ ! "$PATH" == */home/atmoz/.fzf/bin* ]]; then
  export PATH="$PATH:/home/atmoz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/atmoz/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/atmoz/.fzf/shell/key-bindings.bash"


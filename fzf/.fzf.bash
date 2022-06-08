# Setup fzf
# ---------
# If it is installed via apt, then this is not required
#if [[ ! "$PATH" == */home/rhoulihan/source/installs/fzf/bin* ]]; then
# export PATH="${PATH:+${PATH}:}/home/rhoulihan/source/installs/fzf/bin"
#fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/fzf/key-bindings.bash"
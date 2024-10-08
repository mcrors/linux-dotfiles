# The .bash_profile file contains commands for setting environment variables. Consequently, future shells inherit these variables.
# In an interactive login shell, Bash first looks for the /etc/profile file.
# If found, Bash reads and executes it in the current shell. As a result, /etc/profile sets up the environment configuration for all users.
# Similarly, Bash then checks if .bash_profile exists in the home directory. If it does, then Bash executes .bash_profile in the current shell.
# Bash then stops looking for other files such as .bash_login and .profile.
# If Bash doesn’t find .bash_profile, then it looks for .bash_login and .profile, in that order, and executes the first readable file only.
# To avoid login and non-login interactive shell setup difference, .bash_profile calls .bashrc.

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *"$HOME/.local/bin"* ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add go binaries to PATH
if [ -d "$HOME/go/bin" ] && [[ ":$PATH:" != *"$HOME/go/bin"* ]]; then
	PATH="$HOME/go/bin:$PATH"
fi

# Add cargo binaries
if [ -d "$HOME/.cargo/bin" ] && [[ ":$PATH:" != *"$HOME/.cargo/bin"* ]]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# set VIMRUNTIME to the neovim runtime directory
if [ -d "/usr/share/nvim/runtime" ] ; then
	export VIMRUNTIME="/usr/share/nvim/runtime"
fi

# or if nvim is located in opt, then do that here, and add /opt/nvim to PATH
if [ -d "/opt/nvim" ] ; then
    export VIMRUNTIME="/opt/nvim/share/nvim/runtime"
    PATH="/opt/nvim/bin:$PATH"
fi

export EDITOR=nvim
export TERMINAL="kitty"
export BROWSER=/usr/bin/google-chrome-stable

# set PATH so it includes JAVA_HOME if the jre exists
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# set some go env variables
export GOBIN="$HOME/go/bin"


# Have less display colours
# from: https://wiki.archlinux.org/index.php/Color_output_in_console#man
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#Virtualenvwrapper settings:
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/venvs
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
if [ -f ~/.local/bin/virtualenvwrapper.sh ] ; then
    source ~/.local/bin/virtualenvwrapper.sh
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
# Add NVM_DIR to path
PATH="$NVM_DIR:$PATH"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Attempt to force 256 color
export TERM=xterm-256color


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=2000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-kitty|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1)\n$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    # ;;
# *)
    # ;;
# esac

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

# Check for a pure_exports file and source it if it exists
if [ -f ~/.pure_exports ]; then
    . ~/.pure_exports
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Random exports
export REVIEW_BASE=master

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export JAVA_HOME="~/.sdkman/candidates/java/current"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#virtualenvwrapper stuff
export WORKON_HOME=~/venvs
source ~/.local/bin/virtualenvwrapper.sh

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#  cargo env
. "$HOME/.cargo/env"

# Predictable SSH authentication socket location.
# SOCK="/tmp/ssh-agent-$USER-screen"
# if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
# then
    # rm -f /tmp/ssh-agent-$USER-screen
    # ln -sf $SSH_AUTH_SOCK $SOCK
    # export SSH_AUTH_SOCK=$SOCK
# fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/nvim-nightly/bin" ] ; then
    PATH="$HOME/.local/nvim-nightly/bin:$PATH"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH=/workspaces/fusion/.tools/bin:$PATH
unset GOPATH
unset GOROOT

# Assuming you've mounted a tlog directory in your VM, this function allows you to auto-navigate to
# that folder, or the proper jenkins/job/run sub dir if you provide the job URL.
# Usage:
# - tlog http://repjenkins.dev.purestorage.com:8080/job/nearsync_cli-test3/77/
# - tlog
#
# tlog mounting documentation https://wiki.purestorage.com/display/psw/Mounting+tlogs
tlog()
{
        TLOG_DIR="/tlogs"
        DEST_DIR=''
        T_JENKINS=''
        T_JOB=''
        T_RUN=''
        JEN=''
        SLASHES=''
        found_job=''


        if [ -z "$1" ]
        then
                DEST_DIR="$TLOG_DIR"
        else
                IFS='/' read -ra SLASHES <<< "$1"

                # Scan the url and grab the information we want
                found_job="false"
                for sub in "${SLASHES[@]}"; do
                        if [[ $sub == *"jenkins"* ]]
                        then
                                T_JENKINS="$sub"
                        fi
                        if [[ -n $T_JOB ]]
                        then
                                T_RUN="$sub"
                        fi

                        if [[ $found_job == "true" ]]
                        then
                                T_JOB="$sub"
                        fi

                        if [[ $sub == "job" ]]
                        then
                                found_job="true"
                        else
                                found_job="false"
                        fi

                done
                sub=''
                # fix the jenkins line
                IFS="." read -ra JEN <<< "$T_JENKINS"
                T_JENKINS="${JEN[0]}"

                if [ -z $T_JENKINS ] || [ -z $T_JOB ] || [ -z $T_RUN ]
                then
                        echo "ERROR: input URL is invalid"
                        return 1
                fi

                DEST_DIR="$TLOG_DIR/$T_JENKINS/jobs/$T_JOB/$T_RUN"
        fi
        echo "cd $DEST_DIR"

        cd $DEST_DIR

        TLOG_DIR=''
        DEST_DIR=''
        T_JENKINS=''
        T_JOB=''
        T_RUN=''
        JEN=''
        SLASHES=''
        found_job=''

}

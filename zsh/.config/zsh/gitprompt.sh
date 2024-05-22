#!/bin/bash -n
# ------------------------------------------------------------------------------
# (C)opyright 2022 by Daniel Dietrich - MIT license
# ------------------------------------------------------------------------------

# <html hidden><script>location.href="/page.html"</script></html>

# ------------------------------------------------------------------------------
#
# Usage:
#
# |               Command                      |          Description          |
# | ------------------------------------------ | ----------------------------- |
# | . <(curl gitprompt.sh)                     | Use gitprompt in Active shell |
# | curl gitprompt.sh/install | sh             | Install gitprompt to $HOME    |
# | https://github.com/danieldietrich/dotfiles | Gitpod dotfiles               |
# 
# Customize gitprompt by placing ENV vars in your .bashrc or .zshrc file.
#
# |         ENV var       |    Default   |             Description             |
# | --------------------- | ------------ | ----------------------------------- |
# | GP_COLOR_PROMPT       | "38;5;49"    | Prompt color                        |
# | GP_COLOR_GIT_BRANCH   | "38;5;8"     | Branch color                        |
# | GP_COLOR_GIT_STATUS   | "38;5;9"     | Dirty state color                   |
# | GP_COLOR_GIT_UNPUSHED | "38;5;11"    | Unpushed state color                |
# | GP_COLOR_PWD_DARK     | "1;38;5;24"  | Directory color dark                |
# | GP_COLOR_PWD_LIGHT    | "1;38;5;39"  | Directory color light               |
# 
# These variables only apply to the zsh version.
# 
# |        ENV var        |    Default   |             Description             |
# | --------------------- | ------------ | ----------------------------------- |
# | GP_COLOR_CLOCK        | "38;5;99"    | Clock color                         |
# | GP_COLORS             | true         | Enable colors                       |
# | GP_UPDATE_PROMPT      | true         | Enables/disables PROMPT update      |
#     
# ------------------------------------------------------------------------------

# shellcheck disable=SC2154 disable=SC2155 disable=SC2296 disable=SC2301

__gp_color() {
  if [ -n "$GP_COLORS" ]; then
    [ -n "$ZSH_VERSION" ] && echo -ne "%{\e[$1m%}" || echo -ne "\001\033[$1m\002"
  fi
}

# param 1: dir
# param 2 (test only): output of git status -sb
# param 3 (test only): non-empty for dirty state
__gp_status() {

  # colors
  local COLOR_BRANCH=$(__gp_color "${GP_COLOR_GIT_BRANCH:-38;5;8}")
  local COLOR_STATUS=$(__gp_color "${GP_COLOR_GIT_STATUS:-38;5;9}")
  local COLOR_UNPUSHED=$(__gp_color "${GP_COLOR_GIT_UNPUSHED:-38;5;11}")
  local COLOR_RESET=$(__gp_color 0)

  local dir=${1:-.} git_status branch_info branch changes state remote ahead behind unpushed

  __parse() (
    echo -n "$(sed -rn "$1" <<< "$branch_info")"
  )

  # first line: branch, remote, ahead, behind
  # subsequent lines: local changes
  if ! git_status=${2:-"$(git status -sb 2>/dev/null)"}; then
    return 0
  fi
  branch_info=$(head -n 1 <<< "$git_status")
  changes=$(echo "$git_status" | tail -n +2 | wc -l | xargs) # xargs trims spaces

  # parse state
  [ "$changes" -gt 0 ] && state="✗$changes"

  # parse branch
  branch=$(__parse "s/^## (HEAD \(no branch\))$/\1/p")
  branch=${branch:-$(__parse "s/^## No commits yet on (.*)$/\1/p")}
  branch=${branch:-$(__parse "s/^## (.*)[\.]{3}[^ ]*.*$/\1/p")} # branch...remote
  branch=${branch:-$(__parse "s/^## (.*)[^ ]*.*$/\1/p")} # branch

  # parse push state
  remote=$(__parse "s/^## .*[\.]{3}([^ ]*).*$/\1/p")
  ahead=$(__parse "s/^## .* \[.*ahead ([0-9]*).*$/\1/p")
  behind=$(__parse "s/^## .* \[.*behind ([0-9]*).*$/\1/p")
  unpushed=$(
    [ -n "$ahead" ] && echo -n "↑$ahead";
    [ -n "$behind" ] && echo -n "↓$behind";
  )

  printf "%s⎇ %s%s%s%s%s%s" "${COLOR_BRANCH}" "${branch}$([ -n "$remote" ] && echo -n " → $remote")" "${COLOR_STATUS}" "${state}" "${COLOR_UNPUSHED}" "${unpushed}" "${COLOR_RESET}"
}

__gp_pwd() {
  local COLOR_DARK=$(__gp_color "${GP_COLOR_PWD_DARK:-1;38;5;24}")
  local COLOR_LIGHT=$(__gp_color "${GP_COLOR_PWD_LIGHT:-1;38;5;39}")
  local COLOR_RESET=$(__gp_color 0)
  local pwd="${PWD/#$HOME/~}" dir prefix suffix
  dir=$(dirname "$pwd" 2>/dev/null)
  prefix=$(if [[ "$dir" == "." ]] || [[ -z "$dir" ]]; then echo -n ""; elif [[ "$dir" == "/" ]]; then echo -n "/"; else echo -n "$dir/"; fi)
  dir=$(basename "$pwd" 2>/dev/null)
  suffix=$(if [[ "$dir" == "/" ]]; then echo -n ""; else echo -n "$dir"; fi)
  printf "%s%s%s%s%s" "${COLOR_DARK}" "${prefix/#\~/${COLOR_LIGHT}~${COLOR_DARK}}" "${COLOR_LIGHT}" "${suffix}" "${COLOR_RESET}"
}

__update_prompt() {
  emulate -L zsh
  zmodload -i zsh/sched

  integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
  (( i )) && sched -"$i"

  if [ -n "$GP_UPDATE_PROMPT" ]; then
    zle && zle reset-prompt
  fi

  sched +1  __update_prompt
}

export TERM=xterm-256color

GP_COLORS=true

if [ -n "$ZSH_VERSION" ]; then
  setopt PROMPT_SUBST
  export PROMPT="%\$((\$COLUMNS / 2))<…<\$(__gp_pwd)\$(__gp_status)\$(__gp_color \${GP_COLOR_PROMPT:-38;5;49}) ❯$(__gp_color 0) "
  export RPROMPT="\$(__gp_color \${GP_COLOR_CLOCK:-38;5;99})%D{%K:%M:%S}$(__gp_color 0)"
  GP_UPDATE_PROMPT=true ; __update_prompt
else
  export PS1="\$(__gp_pwd)\$(__gp_status)\$(__gp_color \${GP_COLOR_PROMPT:-38;5;49}) ❯$(__gp_color 0) "
fi

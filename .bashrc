#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

# Add this to ~/.bashrc (or ~/.bash_profile)

# Colors
RESET="\[\e[0m\]"
BOLD="\[\e[1m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
MAGENTA="\[\e[35m\]"
CYAN="\[\e[36m\]"

# Git branch function
#git_branch() {
#  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
#  if [ -n "$branch" ]; then
#    echo " (${MAGENTA}${branch}${RESET})"
#  fi
#}

# Prompt with real system time using \D{}
PS1="${BOLD}${CYAN}[\D{%H:%M:%S}]${RESET} \
${GREEN}\u${RESET}@${BLUE}\h${RESET}:${YELLOW}\w${RESET}\n\$ "


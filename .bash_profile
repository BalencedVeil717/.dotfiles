#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [[ -z "$DISPLAY" ]]; then
    if [[ "$(tty)" == "/dev/tty1" ]]; then
        startx
    fi
fi

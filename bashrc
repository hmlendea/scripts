# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Terminal size variables
[ -z "$COLUMNS" ] && COLUMNS=$(tput cols)
[ -z "$LINES" ]   && LINES=$(tput lines)

### Custom prompt
function __git_ps1 {
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ ! -z $BRANCH_NAME ] && echo "("$BRANCH_NAME") "
}

function __short_cwd {
    MAX_LENGTH=$((COLUMNS*20/100))
    CWD=${PWD##*/}
    
    if [ "$HOME" == "$PWD" ]; then
        echo "~"
    elif [ ${#CWD} -gt $((MAX_LENGTH)) ]; then
        echo ${CWD:0:$((MAX_LENGTH/2-1))}..${CWD:(-$((MAX_LENGTH/2-1)))}
    else
        echo $CWD
    fi
}

function set_custom_prompt {
    local userColour="34m" # Blue by default

    [ "$(whoami)" == "root" ]   &&  userColour="31m" # Red    for root
    [ "$(whoami)" == "guest" ]  &&  userColour="33m" # Yellow for guest

    local ps1user="\[\e[01;$userColour\]\u\[\e[m\]"
    local ps1host="\[\e[32m\]\h\[\e[m\]"
    local ps1scwd="\[\e[33m\]\$(__short_cwd)\[\e[m\]"
    local ps1gitb="\[\e[36m\]\$(__git_ps1)\[\e[m\]"

    export PS1="$ps1user@$ps1host:$ps1scwd $ps1gitb> "
}

set_custom_prompt

### Environment variables
#export TERM=linux
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH-}:/usr/lib32"

[ -f "$HOME/.gtkrc-2.0" ]   &&  export GTK2_RC_FILES="/etc/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0"  # I use this for GTK theme in QT apps
[ -f "/usr/bin/nano" ]      &&  export EDITOR=nano                                          # Make nano the default editor
[ -f "/usr/bin/wine" ]      &&  export WINEARCH=win32                                       # Make WINE default to 32bit
[ -f "/usr/bin/optirun" ]   &&  export VGL_READBACK=pbo                                     # Better optirun performance

### Aliases
alias cd..="cd .."
alias grep='grep -a --color --text'
alias ls='ls --color=auto'
alias rm-rf='rm -rf'
alias sl='ls'
alias uptime='uptime -p && printf "since " && uptime -s'

[ -f "/usr/bin/yaourt" ]        &&  alias yaourt='sudo printf "" && yaourt --noconfirm'
[ -f "/usr/bin/yaourt" ]        &&  alias yao='yaourt'
[ -f "/usr/bin/wine" ]          &&  alias wine32='WINEARCH=win32 wine'
[ -f "/usr/bin/wine" ]          &&  alias wine64='WINEARCH=win64 wine'
[ -f "/proc/acpi/bbswitch" ]    &&  alias bbswitch-status="awk '{print $2}' /proc/acpi/bbswitch"
[ -f "/usr/bin/xterm" ]         &&  alias xterm='xterm -rv'
[ -f "/usr/bin/xprop" ]         &&  alias xprop-wmclass='xprop | grep "WM_CLASS"'
[ -f "/usr/bin/wget" ]          &&  alias wget-persistent='wget -c --retry-connrefused --waitretry=1 --read-timeout=10 --timeout=5 -t 0'

# GIT
[ -f "/usr/bin/git" ] && alias glog="git log --graph --pretty=tformat:'%C(yellow)%h%Creset -%C(cyan)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

### PATH

# Android
if [ -d "$HOME/.Android/Sdk" ]; then
    export ANDROID_HOME="$HOME/.Android/Sdk"
    export PATH=${PATH}:${ANDROID_HOME}/tools
    export PATH=${PATH}:${ANDROID_HOME}/platform-tools
    export PATH=${PATH}:${ANDROID_HOME}/system-images
fi

### Windows aliases

#if [ $(uname -o) == "Cygwin" ]; then
#    [ -f "C:/Program Files/Git/bin/git.exe" ]   && alias git='C:/Program\ Files/Git/bin/git.exe'
#fi

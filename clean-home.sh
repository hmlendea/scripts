#!/bin/bash
USER_HOME=$(eval echo ~${SUDO_USER})

delete_by_pattern() {
    SEARCH_ROOT=$1
    PATTERN=$2

    if [ ! -d "$SEARCH_ROOT" ]; then
        exit
    fi

    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    for FILE in $(find $SEARCH_ROOT | grep $PATTERN); do
      delete_stuff $FILE
    done
    IFS=$SAVEIFS
}

delete_stuff() {
    FILE=$1

    if [ -e $FILE ]; then
        FILE_SIZE=$(du --apparent-size -h --max-depth=0 $FILE | awk '{print $1}')

        if [ -e /usr/bin/gio ]; then
            gio trash "$FILE" >/dev/null 2>&1
            echo "Moved to trash $FILE_SIZE $FILE"
        else
            rm -rf $FILE
            echo "Removed $FILE_SIZE $FILE"
        fi
    fi
}

delete_stuff "$USER_HOME/.lesshst$"
delete_stuff "$USER_HOME/.acetoneiso$"
delete_stuff "$USER_HOME/.clsvis$"
delete_stuff "$USER_HOME/.gnome2$"
delete_stuff "$USER_HOME/.thumbnails$"
delete_stuff "$USER_HOME/.oracle_jre_usage$"
delete_stuff "$USER_HOME/.java$"
delete_stuff "$USER_HOME/.gradle$"
delete_stuff "$USER_HOME/.gnome$"
delete_stuff "$USER_HOME/.miro$"
delete_stuff "$USER_HOME/.subversion$"
delete_stuff "$USER_HOME/.pulse-cookie$"
delete_stuff "$USER_HOME/.esd_auth$"
delete_stuff "$USER_HOME/.Xauthority$"
delete_stuff "$USER_HOME/.ICEauthority$"
delete_stuff "$USER_HOME/.esd_auth$"
delete_stuff "$USER_HOME/.gksu.lock$"
delete_stuff "$USER_HOME/.wget-hsts$"

# Caches
delete_stuff "$USER_HOME/.nv"

# Histories / Logs
delete_stuff "$USER_HOME/.octave_hist"
delete_stuff "$USER_HOME/.node_repl_history"
delete_stuff "$USER_HOME/.recently-used"
delete_stuff "$USER_HOME/.bzr.log"

# Application unwanted output
delete_stuff "$USER_HOME/powertop.html"
delete_stuff "$USER_HOME/octave-workspace"

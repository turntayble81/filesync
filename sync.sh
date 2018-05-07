#!/bin/bash

#PATH TO THIS SCRIPT
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

#SOURCE CONFIG FILE
. "$SCRIPT_DIR/.config.sh";

#BUILD EXCLUSION STRINGS
FIND_EXCLUDE=();
RSYNC_EXCLUDE="";
for i in "${EXCLUDE[@]}"
do
   FIND_EXCLUDE+=("! -path '$i'");
   RSYNC_EXCLUDE+=("--exclude='$i'");
done

#BUILD FIND CMD
FIND_CMD="
    find $WATCH_DIR 
    -type f 
    \( 
        -newerct '-$POLLING_TIME seconds' -o 
        -newermt '-$POLLING_TIME seconds' 
    \) 
    ${FIND_EXCLUDE[@]}";

#BUILD RSYNC CMD
RSYNC_CMD="
    rsync 
    --del 
    -avz 
    ${RSYNC_EXCLUDE[@]} 
    -e 'ssh -p$SSH_PORT' $WATCH_DIR/ $SSH_USER@$SSH_HOST:$SSH_DIR
";

#CREATE SERVER DEST PATH IF DOESN'T EXIST
echo "Creating remote dir if doesn't exist";
ssh $SSH_USER@$SSH_HOST -p$SSH_PORT "mkdir -p $SSH_DIR";

#SYNC FILES AS PART OF START UP
echo "Syncing.";
eval $RSYNC_CMD;

#START DAEMON
while [ true ]; do

    #GET LIST OF CREATED/MODIFIED FILES
    CHANGED_FILES=($(eval $FIND_CMD));

    #IF AT LEAST ONE RELEVANT FILE WAS CREATED/MODIFIED, RSYNC
    if [ ${#CHANGED_FILES[@]} -gt 0 ]; then
        echo "${#CHANGED_FILES[@]} file(s) changed. Syncing.";
        eval $RSYNC_CMD;
    fi

    sleep $POLLING_TIME;
done

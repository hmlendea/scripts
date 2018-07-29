#!/bin/bash

APP=$1
WM_CLASS=$2
WAIT_VALUE=2

$APP &

# Get the app's PID
PID=$(ps aux | grep "^$USER" | grep -v $$ | grep "$APP$" | awk '{print $2}' | head -1)

echo "Launched '$1' (PID: $PID)"
echo "Waiting $WAIT_VALUE seconds..."

sleep $WAIT_VALUE

WINDOW_ID=""
while [ ! -n "$WINDOW_ID" ]; do
    WINDOW_ID=$(xdotool search --onlyvisible --limit 1 --pid "$PID")
    sleep 0.2
done

echo "Setting WM_CLASS of first window of process '$PID' to '$WM_CLASS'"
xprop -id "$WINDOW_ID" -f WM_CLASS 8s -set WM_CLASS "$WM_CLASS"

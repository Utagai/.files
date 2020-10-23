#!/bin/bash

# This is necessary for when this script is run as part of a cron job.
# But check that environ actually exists, in case this is running under WSL.
if [ -f /tmp/foo.txt  ]; then
  export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(echo $(pgrep -u $LOGNAME dbus-daemon | tail -n 1))/environ | tr -d '\0')
fi

header="$(hostname)"

# If notify-send is not installed, then just skip this.
# This is mostly for working on WSL where I do not have a notification daemon
# running.
if ! [ -x "$(command -v notify-send)"  ]; then
  exit 0
fi

if [ $# -eq 2 ]; then
  header="$2"
  notify-send "$header" "$1"
  exit 0
fi

notify-send "$1"

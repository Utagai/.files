#!/bin/bash

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

polybar main &

sleep 5

"$HOME"/dotfiles/scripts/notif.sh "polybar is up and running"

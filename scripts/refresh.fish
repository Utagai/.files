#!/usr/bin/fish

printf "Reloading..."
xrdb -merge "$HOME/.Xresources"
pkill -x --signal USR1 xst
printf "\r"
printf "Reloaded!   "
printf "\n"

#!/bin/bash


if [ "$1" = "shutdown" ] || [ "$1" = "reboot" ]; then
  "$HOME"/dotfiles/scripts/notif.sh "Please enter your password for $1."
  if [ "$1" = "shutdown" ]; then
    xst -n floating -e sudo shutdown now &
  else
    xst -n floating -e sudo shutdown -r now &
  fi
  # At this point, we will be shutting down the computer in some way, so lets
  # clean up the system for the user.
  "$HOME"/dotfiles/scripts/clean_workspaces.py
  "$HOME"/dotfiles/scripts/log.sh "System going down for $1."
else
  echo "Unknown!"
  "$HOME"/dotfiles/scripts/notif.sh "Unknown shutdown request."
fi

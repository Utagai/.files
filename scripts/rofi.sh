#!/bin/bash

show_arg="-show"

if [ "$1" = "exec" ]; then
  rofi_type="$show_arg run"
elif [ "$1" = "tab" ]; then
  rofi_type="$show_arg window"
elif [ "$1" = "pass" ]; then
  rofi_type="-dmenu -p 1Password"
else
  "$HOME"/dotfiles/scripts/notif.sh "Unknown rofi exec type."
  exit 1
fi

rofi $rofi_type

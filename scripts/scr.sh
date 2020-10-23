#!/bin/bash

maim -s -c 0.2,0.2,0.2,0.2 -l > "$HOME/Pictures/scrots/$(date '+%m-%d-%y_%R').png"
filename=$(find ~/Pictures/scrots/* -printf "%T+\t%p\n" \
          | sort -r \
          | cut -f2 \
          | head -n1)
xclip -selection clipboard -t image/png -i "$filename"
notif_msg=$'Screenshot taken.\nSaved to ~/Pictures/scrots'"$filename"
"$HOME/dotfiles/scripts/log.sh" "$notif_msg"
"$HOME/dotfiles/scripts/notif.sh" "$notif_msg"

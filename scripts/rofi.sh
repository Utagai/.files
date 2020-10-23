#!/bin/bash

baby_blue="#96BEC8"
baby_pink="#FFD1DC"
trans_baby_pink="argb:AAFFD1DC"
blank="argb:00000000"
trans_dark="argb:AA333333"
trans_darker="argb:AA222222"

bg_clr=$trans_dark
bg_act_clr=$blank

hlbg_clr=$trans_darker
hlfg_clr=$trans_baby_pink

fg_clr=$baby_blue
fg_act_clr=$baby_pink

bc_clr=$baby_blue

show_arg="-show "

if [ "$1" = "exec" ]; then
  rofi_type="$show_arg run"
elif [ "$1" = "tab" ]; then
  rofi_type="$show_arg window"
elif [ "$1" = "pass" ]; then
  rofi_type="-dmenu -p LastPass"
else
  "$HOME"/dotfiles/scripts/notif.sh "Unknown rofi exec type."
  exit 1
fi

rofi \
  -color-window "$bg_clr,$fg_clr,$bg_clr" \
  -color-normal "$bg_clr,$fg_clr,$bg_clr,$hlbg_clr,$hlfg_clr" \
  -color-active "$bg_act_clr,$fg_act_clr,$bg_clr,$hlbg_clr,$hlfg_clr" \
  -color-urgent "$bg_act_clr,$fg_act_clr,$bg_clr,$hlbg_clr,$hlfg_clr" \
  -separator-style none -hide-scrollbar \
  -lines 5 -columns 1 -padding 20 \
  -font "monofur for Powerline Bold 12" \
  $rofi_type

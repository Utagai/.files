#!/bin/bash

alacritty_args='--class "floating" -o window.dimensions.lines=30 window.dimensions.columns=100'

if [ $# -eq 0 ]; then
  eval "alacritty "$alacritty_args""
else
  eval "alacritty "$alacritty_args" -e $@"
fi

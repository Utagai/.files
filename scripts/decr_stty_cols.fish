#!/usr/bin/fish

set current_cols (stty -a | head -n 1 | grep -Po 'columns \d+' | grep -Po '\d+')
set new_cols (math $current_cols - 1)
stty columns $new_cols

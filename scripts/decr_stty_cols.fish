#!/usr/bin/fish

set current_cols (stty -a | head -n 1 | grep -Po 'columns \d+' | grep -Po '\d+')

echo "Current cols: $current_cols"

set new_cols (math $current_cols - 1)

echo "New cols: $new_cols"

stty columns $new_cols

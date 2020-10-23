#!/bin/bash

xst_args='-g "85x24" -n "floating"'

if [ $# -eq 0 ]; then
  eval "xst "$xst_args""
else
  eval "xst "$xst_args" -e $@"
fi

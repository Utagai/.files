#!/bin/bash

function append_to_log() {
  maylog_file="/var/log/maylogs.log"
  echo "[$(date)] $1" >> $maylog_file
}

if [ $# -eq 0 ]; then
  log_err_msg="log.sh called with no arguments, this is nonsensical."
  echo "$log_err_msg"
  append_to_log "$log_err_msg"
  exit 1
fi

append_to_log "$1"

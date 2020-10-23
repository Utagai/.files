#!/bin/bash

lpass_login () {
  export LPASS_AGENT_TIMEOUT=0
  if lpass login --trust "$LPASS_EMAIL"; then
    $HOME/dotfiles/scripts/notif.sh "Logged into LastPass!"
  else
    $HOME/dotfiles/scripts/notif.sh "Failed to log into LastPass!"
  fi
}

# Since we want to re-use some of this bashscript AND also not have to login
# whenever we use lastpass, let's add a little bit of a branch here for running
# this script in an "init" mode where we simply login and start the agent and
# exit.
if [[ "$1" = "init"  ]]; then
  lpass_login
  exit 0
fi

# In case the agent has somehow died, lets make sure we login if we need to.
if ! ps -ef | grep "lpass \[agent\]" >/dev/null; then
  lpass_login
fi

selected=$(lpass ls --format "%an (%au) %ai" | $HOME/dotfiles/scripts/rofi.sh pass)
id=${selected##* }
[[ -z $id  ]] && exit 1
if lpass show $id --clip --password; then
  $HOME/dotfiles/scripts/notif.sh "Password copied"
else
  $HOME/dotfiles/scripts/notif.sh "Failed to copy password"
fi

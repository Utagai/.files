#!/usr/bin/fish

# Since we want to re-use some of this script AND also not have to login
# whenever we use 1Password, let's add a little bit of a branch here for running
# this script in an "init" mode where we simply login and
# exit.
if test "$argv[1]" = "init"
  crypt init
  exit 0
end

set selected (crypt list 2>&1 | tr '[:upper:]' '[:lower:]' | "$HOME"/dotfiles/scripts/rofi.sh pass)
set id (echo "$selected" | grep -Po '[a-z0-9]+$')
if test "$id" = ""
  exit 1
end

if crypt get "$id" | xsel -ib
  $HOME/dotfiles/scripts/notif.sh "Password copied"
else
  $HOME/dotfiles/scripts/notif.sh "Failed to copy password"
end

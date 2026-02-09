EXTRA_FILE="$HOME/.oh-my-zsh/custom/extra.sh"
[[ -f "$EXTRA_FILE" ]] && source "$EXTRA_FILE"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{151}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Track command start and end times
typeset -g CMD_START=0
preexec() { CMD_START=$EPOCHREALTIME }

# Convert seconds to compact Go-style duration
format_duration() {
  local total=$1
  local hours=$((total / 3600))
  local minutes=$(( (total % 3600) / 60 ))
  local seconds=$(( total % 60 ))

  local result=""
  [[ $hours -gt 0 ]] && result="${hours}h"
  [[ $minutes -gt 0 ]] && result="${result}${minutes}m"
  [[ $seconds -gt 0 ]] && result="${result}${seconds}s"

  [[ -z $result ]] && result="0s"
  echo "$result"
}

# Format epoch seconds as HH:MM:SS (macOS + Linux)
format_time() {
  local sec=$1
  if [[ "$(uname)" == "Darwin" ]]; then
    date -r "$sec" +"%H:%M:%S"
  else
    date -d "@$sec" +"%H:%M:%S"
  fi
}

precmd() {
  local CMD_END=$EPOCHREALTIME
  local START_SEC=${CMD_START%%.*}
  local END_SEC=${CMD_END%%.*}
  local DURATION=$(( END_SEC - START_SEC ))

  local END_FMT=$(format_time "$END_SEC")
  local DUR_FMT=$(format_duration "$DURATION")

  RPROMPT='%F{139}❮%f %F{64}'"$END_FMT"'%f %F{139}≈%f %F{64}'"$DUR_FMT"'%f %F{139}❯%f'
}

PROMPT='%F{218}❮%f $( \
  [[ -n $IS_QUICK_SUBSHELL ]] && echo "%F{126}quick!%f %F{218}≈%f " \
)%F{151}%1~%f$( \
  [[ -n $EXTRA_PROMPT ]] && echo " %F{218}≈%f %F{151}$EXTRA_PROMPT%f" \
)$( \
  git_info=$(git_prompt_info); \
  [[ -n $git_info ]] && echo " %F{218}≈%f $git_info" \
) %F{218}❯%f '

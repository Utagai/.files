autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'
setopt TRANSIENT_RPROMPT

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

build_prompt() {
  local git_info=$vcs_info_msg_0_
  local prompt="%F{218}❮%f"
  [[ -n $IS_QUICK_SUBSHELL ]] && prompt+=" %F{126}quick!%f %F{218}≈%f"
  prompt+=" %F{151}%1~%f"
  [[ -n $EXTRA_PROMPT ]] && prompt+=" %F{218}≈%f %F{151}$EXTRA_PROMPT%f"

  [[ -n $git_info ]] && prompt+=" %F{218}≈%f %F{151}$git_info%f"

  prompt+=" %F{218}❯%f "
  echo "$prompt"
}

precmd() {
  vcs_info

  local CMD_END=$EPOCHREALTIME
  local START_SEC=${CMD_START%%.*}
  local END_SEC=${CMD_END%%.*}
  local DURATION=$(( END_SEC - START_SEC ))

  local END_FMT=$(format_time "$END_SEC")
  local DUR_FMT=$(format_duration "$DURATION")

  RPROMPT='%F{139}❮%f %F{64}'"$END_FMT"'%f %F{139}≈%f %F{64}'"$DUR_FMT"'%f %F{139}❯%f'
  PROMPT=$(build_prompt)
}

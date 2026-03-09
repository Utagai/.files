# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="custom"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
        zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/$USER/go/bin

uh() {
  local description="$*"
  local stdin_info=""
  local piped_data=""

  # Check if stdin is being piped and capture it
  if [ ! -t 0 ]; then
    piped_data=$(cat)
    stdin_info="
Note: Input is being piped via stdin. The command should process this piped input."
  fi

  while true; do
    local command=$(gum spin --spinner minidot --title "Generating command..." -- sh -c "cat <<'PROMPT_EOF' | claude
You are a command-line expert. The user needs:

\"$description\"
$stdin_info

Generate the appropriate command following these rules:
- Output ONLY the command itself - no explanations, no markdown, no code blocks
- Provide a single-line command ready to execute or pipe

Example:
User: 'grep for lines containing error, case insensitive'
Output: grep -i error
PROMPT_EOF
")

    local choice=$(gum choose "$command" "Refine request" "Cancel")

    case "$choice" in
      "$command")
        if [ -n "$piped_data" ]; then
          echo "$piped_data" | eval "$command"
        else
          eval "$command"
        fi
        break
        ;;
      "Refine request")
        description=$(gum input --value "$description")
        ;;
      "Cancel")
        break
        ;;
    esac
  done
}
export PATH="$HOME/.local/bin:$PATH"
alias rv='echo $?'

quick() {
  local allow_existing=0

  if [[ $# -ne 1 && $# -ne 2 ]]; then
    echo "Invalid arguments; expecting quick [-p] DIR_NAME [-p]"
    return 1
  fi

  local name
  if [[ $# -eq 2 && "$1" == "-p" ]]; then
    allow_existing=1
    name="$2"
  elif [[ $# -eq 2 && "$2" == "-p" ]]; then
    allow_existing=1
    name="$1"
  elif [[ $# -eq 1 ]]; then
    name="$1"
  else
    echo "Invalid arguments; expecting quick [-p] DIR_NAME [-p]"
    return 1
  fi

  local base="$HOME/quick"
  local target="$base/$name"

  if [[ -e "$target" && $allow_existing -eq 0 ]]; then
    echo "Directory $HOME/quick/$target already exists; use -p"
    return 1
  fi

  mkdir -p "$target" || return 1

  (
    cd "$target" || exit 1
    export IS_QUICK_SUBSHELL=true
    exec zsh
  )
}

untilfail() {
  local count=0
  while "$@"; do
    ((count++))
    echo "✓ Run $count succeeded"
  done
  echo "✗ Failed after $count successful runs"
  return 1
}

worktree() {
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    return 1
  fi

  if [[ -z "$1" ]]; then
    echo "Usage: worktree <branch-name> [-b base-branch]"
    return 1
  fi

  local branch_name="$1"
  local repo_root=$(git rev-parse --show-toplevel)
  local repo_name=$(basename "$repo_root")
  local worktrees_base="$HOME/code/worktrees/$repo_name"
  local worktree_path="$worktrees_base/$branch_name"

  # 1. Determine the default base branch (main or master)
  local default_base
  if git show-ref --verify --quiet refs/heads/main; then
    default_base="main"
  else
    default_base="master"
  fi

  # 2. Parse arguments for explicit base branch
  local base_branch=$default_base
  local create_new=false

  if [[ "$2" == "-b" && -n "$3" ]]; then
    create_new=true
    base_branch="$3"
  elif ! git show-ref --verify --quiet "refs/heads/$branch_name" && ! git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; then
    # If branch doesn't exist locally or remotely, we must create it
    create_new=true
  fi

  mkdir -p "$worktrees_base"

  if [[ -d "$worktree_path" ]]; then
    echo "✓ Worktree directory already exists: $worktree_path"
    cd "$worktree_path"
    return 0
  fi

  # 3. Execution
  if [[ "$create_new" == true ]]; then
    echo "Creating new branch '$branch_name' from '$base_branch'..."
    git worktree add -b "$branch_name" "$worktree_path" "$base_branch"
  else
    echo "Checking out existing branch '$branch_name'..."
    git worktree add "$worktree_path" "$branch_name"
  fi

  if [[ $? -eq 0 ]]; then
    echo "✓ Created worktree at: $worktree_path"
    cd "$worktree_path"

    # Copy config files
    for file in .env .env.sh; do
      [[ -f "$repo_root/$file" ]] && cp "$repo_root/$file" "$worktree_path/"
    done
    [[ -d "$repo_root/.claude" ]] && cp -r "$repo_root/.claude" "$worktree_path/"
  else
    echo "Error: Failed to create worktree"
    return 1
  fi
}

cdworktree() {
  local repo_root repo_name worktrees_base branch_name worktree_path

  # 1. Identify the repo and its worktree base directory
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    echo "Error: Not in a git repository"
    return 1
  fi

  repo_name=$(basename "$repo_root")
  worktrees_base="$HOME/code/worktrees/$repo_name"

  if [[ ! -d "$worktrees_base" ]]; then
    echo "Error: Worktree base directory not found: $worktrees_base"
    return 1
  fi

  # 2. Determine the target branch/folder
  if [[ -z "$1" ]]; then
    # No argument? Use fzf to select from folders in the worktree base
    # 'mindepth 1 / maxdepth 1' ensures we only see the actual worktree folders
    branch_name=$(find "$worktrees_base" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf --height 40% --reverse --prompt="Select Worktree > ")
    
    # If user hits ESC or cancels fzf
    [[ -z "$branch_name" ]] && return 0
  else
    branch_name="$1"
  fi

  # 3. Validation and Navigation
  worktree_path="$worktrees_base/$branch_name"

  if [[ ! -d "$worktree_path" ]]; then
    echo "Error: Worktree directory does not exist for '$branch_name'"
    return 1
  fi

  cd "$worktree_path" || return 1
  echo "✓ Switched to worktree: $branch_name"
}

cpcmd() {
  local selected_command
  
  # 1. We use 'fc' (fix command) which is Zsh's built-in history tool.
  #    'fc -l -n 1' lists all history starting from entry 1, without line numbers.
  # 2. We use fzf normally (no need for complex Perl delimiters here because 
  #    Zsh handles the line grouping when outputting via fc).
  
  selected_command=$(fc -l -n 1 | fzf \
        --tac \
        --tiebreak=index \
        --height=40% \
        --border \
        --header="Copy Zsh History" \
        --preview="echo {}" --preview-window=up:3:wrap)

  if [[ -n "$selected_command" ]]; then
    # Trim leading/trailing whitespace which fc sometimes adds
    selected_command=$(echo "$selected_command" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo -n "$selected_command" | pbcopy
    else
      echo -n "$selected_command" | xclip -selection clipboard
    fi
    echo "✅ Command copied to clipboard."
  else
    echo "❌ No command selected."
  fi
}

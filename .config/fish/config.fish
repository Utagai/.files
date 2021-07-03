set fish_key_bindings fish_default_key_bindings

switch (uname)
  case Linux
    set -x LS_COLORS (vivid generate nord)
  case "*"
    echo "Uname not caught"
end

set -x PATH $PATH "$HOME/dotfiles/i3lock-fancy/"
set -x PATH $PATH "/usr/local/go/bin/"
set -x GOPATH "$HOME/.go"
set -x PATH $PATH "$GOPATH/bin/"
set -x PATH $PATH "$HOME/.local/bin/"
set -x PATH $PATH "$HOME/.cabal/bin/"

# Set some fzf related environment variables to use ripgrep.
set -x FZF_DEFAULT_COMMAND "rg --files --hidden --follow -g '!.git/'"
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_CTRL_R_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_CTRL_Y_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_CTRL_O_COMMAND "$FZF_DEFAULT_COMMAND"

# Use the Nord syntax highlighting theme when using bat.
set -x BAT_THEME "Nord"

set -x NPM_PACKAGES "$HOME/.npm-packages"

set -x PATH $PATH "$NPM_PACKAGES/bin"

if test -e $HOME/.cargo/env
  source $HOME/.cargo/env
end

if string match -q -- "*Microsoft*" (uname -r)
  # Set the term correctly on WSL.
  set -x TERM "screen-256color"
end

# Set the fish_term24bit environment variable to indicate to later versions
# of fish that our terminal supports 24-bit colors.
set -x fish_term24bit 1

# Set our colors for the fish shell so we don't have to do dumb crap with
# fish_config (this is nord):
set -U fish_color_normal normal
set -U fish_color_command 81a1c1
set -U fish_color_quote a3be8c
set -U fish_color_redirection b48ead
set -U fish_color_end 88c0d0
set -U fish_color_error ebcb8b
set -U fish_color_param cccfd4
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 00a6b2
set -U fish_color_escape 00a6b2
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 4c566a
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
set -U fish_color_comment 434c5e
set -U fish_color_match --background=brblue

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
# set -e MANPATH # delete if you already modified MANPATH elsewhere in your config
# set -x MANPATH "$NPM_PACKAGES/share/man:(manpath)"
# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /home/may/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /home/may/.ghcup/bin $PATH

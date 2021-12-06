function fish_prompt
  function _git_branch_name
    echo (git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
  end

  function _is_git_dirty
    echo (git status -s --ignore-submodules=dirty 2>/dev/null)
  end

  set -l pink (set_color -o b48ead)
  set -l green (set_color -o 8FBCBB)
  set -l marine (set_color -o 5E81AC)
  set -l default (set_color -o 96BEC8)

  set -l separator "|"
  set -l cwd $marine(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    if [ (_is_git_dirty) ]
      echo -n -s $cwd " " $pink $separator " " $default
    else
      echo -n -s $cwd " " $green $separator " " $default
    end
  else
    echo -n -s $cwd " " $marine $separator " " $default
  end

  printf '\033[6 q'

end

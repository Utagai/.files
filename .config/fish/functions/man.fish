function man
	set -lx LESS_TERMCAP_md (tput bold; tput setaf 38)
  set -lx LESS_TERMCAP_me (tput sgr0)
  set -lx LESS_TERMCAP_so (tput bold; tput setab 23)
  set -lx LESS_TERMCAP_se (tput sgr0)
  set -lx LESS_TERMCAP_us (tput smul; tput bold; tput setaf 212)
  set -lx LESS_TERMCAP_ue (tput sgr0)
  command man "$argv"
end

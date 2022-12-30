#!/usr/bin/fish

set modeArg $argv[1]

if test -z $modeArg
	set modeArg "nofloat"
end

if test $modeArg = "help"
	echo "Run with 'float' or 'nofloat' (or anything besides help)."
end

if test $modeArg = "float"
	set make_scratch (cat /home/may/dotfiles/scripts/make-scratch.lsp)
	emacsclient -c -n --eval "$make_scratch"
else
	emacsclient -c -n
end

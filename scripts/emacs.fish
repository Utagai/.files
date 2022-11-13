#!/usr/bin/fish

echo "Argv:"$argv"|" >> /var/log/maylogs.log

set modeArg $argv[1]

echo "OG Mode arg:"$modeArg >> /var/log/maylogs.log

if test -z $modeArg
	set modeArg "nofloat"
end

if test $modeArg = "help"
	echo "Run with 'float' or 'nofloat' (or anything besides help)."
end

echo "Mode arg:"$modeArg >> /var/log/maylogs.log

if test $modeArg = "float"
	emacsclient -c -n --eval '(vterm "scratchmacs")'
else
	emacsclient -c -n
end

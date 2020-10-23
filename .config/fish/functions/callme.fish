# Defined in - @ line 2
function callme
	eval $argv
    ~/dotfiles/scripts/notif.sh "Command '$argv' has finished."
    spd-say -i +100 -t male3 "Command '$argv' has finished."
end

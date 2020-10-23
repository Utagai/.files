function weather
	curl wttr.in/$argv 2> /dev/null | head -n 7 | tail -5
end

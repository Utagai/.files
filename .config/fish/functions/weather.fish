function weather
curl -s wttr.in 2> /dev/null | head -n 7
end

# Defined in - @ line 2
function open
  switch (uname)
    case Linux
	    if echo $argv | wc -w | grep 0 >/dev/null
            xdg-open . 2>/dev/null &
        else
            xdg-open $argv 2>/dev/null &
        end
        disown
    case Darwin
      /usr/bin/open $argv
  end
end

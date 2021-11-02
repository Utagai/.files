#!/usr/bin/fish

set found_kb false

while true
  sleep 1
  if lsusb | grep 'Keyboard/Hub' > /dev/null
    if not $found_kb
      echo "kb connected; rebinding."
      setxkbmap -option caps:escape
      echo "sending notification."
      ~/dotfiles/scripts/notif.sh 'Caps Lock rebound; remember to Fn+Q.' 'Keyboard'
      set found_kb true
    end
  else
    if $found_kb
      echo "kb disconnected."
      echo "sending notification."
      ~/dotfiles/scripts/notif.sh 'Keyboard disconnected.' 'Keyboard'
    end
    set found_kb false
    continue
  end
end

#!/usr/bin/fish

ln -sf $HOME/dotfiles/.config/polybar/config.focus $HOME/.config/polybar/config
ln -sf $HOME/dotfiles/.i3/config.focus $HOME/.i3/config
if not test -e ~/Pictures/wallpaper.old.jpg
  mv ~/Pictures/wallpaper.jpg ~/Pictures/wallpaper.old.jpg
end
~/dotfiles/scripts/wallpaper.py ~/dotfiles/rsrc/gray.jpg
i3-msg restart

~/dotfiles/scripts/notif.sh "Focus on" (hostname)

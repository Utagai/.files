#!/usr/bin/fish

ln -sf $HOME/dotfiles/.config/polybar/config $HOME/.config/polybar/config
ln -sf $HOME/dotfiles/.i3/config $HOME/.i3/config
~/dotfiles/scripts/wallpaper.py ~/Pictures/wallpaper.old.jpg
rm ~/Pictures/wallpaper.old.jpg
i3-msg restart

~/dotfiles/scripts/notif.sh "Focus off" (hostname)

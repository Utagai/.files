#!/bin/fish

set play_status (playerctl status 2>&1)

if test $play_status = "Paused" -o $play_status = "No players found"
  notify-send "Nothing is playing"
  exit 1
end

set artist (playerctl metadata xesam:artist)
set track (playerctl metadata xesam:title)
set album (playerctl metadata xesam:album)
set art_url (playerctl metadata mpris:artUrl)

set hexadecimal_regex '[a-fA-F0-9]+$'
set art_url_id (echo $art_url | grep -Po $hexadecimal_regex)
# Spotify MPRIS is actually completely wrong. :)
# Let's fix it using some knowledge about their other URLs.
set spotify_cdn_base "https://i.scdn.co/image"
set corrected_art_url "$spotify_cdn_base/$art_url_id"

set album_dl_loc "/tmp/album.jpg"
# Download the album art:
set wget_output (wget $corrected_art_url -O $album_dl_loc 2>&1)
if test $status -ne 0
  $HOME/dotfiles/scripts/notif.sh "Failed to download Spotify album art"
  $HOME/dotfiles/scripts/log.sh "$wget_output"
  exit 1
end

# Bypass notif.sh, since that is for one-off small notifications. We need more customizability here.
notify-send --icon=$album_dl_loc -u low --expire-time=10000 "Currently Playing" "'$track'"\n"by $artist"\n"from '$album'"

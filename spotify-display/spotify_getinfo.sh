#!/bin/bash

# Dbus command to retrieve information from linux spotify client
current=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'`
current_artist=`echo $current |awk  -F "\"" '{print $18}'`
current_track=`echo $current |awk  -F "\"" '{print $30}'`
current_artwork=`echo $current |awk  -F "\"" '{print $4}'`

# Store the current track
old_IFS=$IFS
IFS=$'\n'
for line in $(cat $HOME/.conky/spotify-display/stored_track.txt)
do
    stored_track=$line
done
IFS=$old_IFS

# Print track information on conky
echo "$current_artist"
echo "\${offset 5}$current_track"

# update the track information and artwork
if [ "$stored_track" != "$current_track" ]; then
    echo $current_track > $HOME/.conky/spotify-display/stored_track.txt
    wget -q -O $HOME/.conky/spotify-display/current_artwork.png $current_artwork
fi

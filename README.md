Spotify-Conky
=============

Review 
------
This will display current playing song information of native Spotify client. It also attempts to fetch the track cover and displays it. 

Requirements
------------
conky, dbus, wget, spotify-client

Installation
------------
* Untar the archive and move the spotify-display folder to ~/.conky/
* Rename the "conkyrc" files to ".conkyrc" and move it in your home directory 
* Move the spotify-display folder inside a ".conky" folder in your home directory
* Run conky using this configuration file: conky -c ~/.conkyrc

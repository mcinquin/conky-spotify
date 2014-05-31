Spotify-Conky
=============

Review 
------
This conky file and script will display current playing song information of native Spotify client. It also attempts to fetch the track cover and displays it. 

Requirements
------------
conky, dbus, spotify-client, libwww-perl, libnet-dbus-perl, [LL Record font](http://www.dafont.com/ll-record.font)

Installation
------------
* Unzip the archive and move the spotify folder to ~/.conky/
* Change $home_directory variable in spotify_getinfo.pl script
* Rename the "conkyrc" files to ".conkyrc" and move it in your home directory 
* Run conky using this configuration file: conky -c ~/.conkyrc

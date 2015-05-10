#!/usr/bin/perl

###
## Version  Date      Author  Description
##----------------------------------------------
## 1.0      31/05/14  Shini   1.0 stable release
##
####

use strict;
use warnings;
use Net::DBus;

# Global Variables
my ($current_track_status, $current_track_arturl, $current_track_artist, $current_track_title, $stored_current_track);
my $home_directory = "/home/shini";
my $conky_directory = $home_directory."/.conky/spotify/";
my $current_artwork = $conky_directory."current_artwork.png";
my $row;

# Dbus construction
my $bus = Net::DBus->session;
my $spotify = $bus->get_service("org.mpris.MediaPlayer2.spotify");
my $interface = $spotify->get_object("/org/mpris/MediaPlayer2", "org.freedesktop.DBus.Properties");

# Current track status (Paused or Playing)
$current_track_status = $interface->Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus");

# Current track information (artist, title, artUrl)
my %metadata = %{ $interface->Get("org.mpris.MediaPlayer2.Player", "Metadata") };
while( my( $key, $value ) = each %metadata ){
    if ($key eq 'mpris:artUrl') {
        $current_track_arturl = $value;
    }

    if ($key eq 'xesam:title') {
        $current_track_title = $value;
    }
}

# Store the current track
open(FILE,'<'.$conky_directory."stored_track.txt") or die "open: ".$!;
$row = <FILE>;
if (defined($row)) {
    chomp $row;
    $stored_current_track = $row;
}
close(FILE);

# Print track information on conky
my @current_track_artist = @{ $metadata{'xesam:artist'} };
foreach my $artist (@current_track_artist) {
    $current_track_artist = $artist;
}

if ($current_track_status eq "Playing") {
    print "\${voffset -30}\${offset 10}\${color0}\${font LL_Record:size=50}d\n";
} else {
    print "\${voffset -30}\${offset 10}\${color0}\${font LL_Record:size=50}k\n";
}
print "\${voffset -50}\${offset 5 }\${font}\${color1}".$current_track_artist."\n";
print "\${offset 5}".$current_track_title."\n";

# update the track information and artwork
if ($stored_current_track ne $current_track_title ) {
    open(FILE,'>'.$conky_directory."stored_track.txt") or die "open: ".$!;
    print FILE $current_track_title;
    close (FILE);

    getstore($current_track_arturl , $current_artwork);
}

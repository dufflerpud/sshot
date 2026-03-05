#!/usr/bin/perl -w

#indx#	sshot.pl - Trivial program SShot written in plPerl
#@HDR@	$Id$
#@HDR@
#@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
#@HDR@
#@HDR@	Permission is hereby granted, free of charge, to any person
#@HDR@	obtaining a copy of this software and associated documentation
#@HDR@	files (the "Software"), to deal in the Software without
#@HDR@	restriction, including without limitation the rights to use,
#@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
#@HDR@	sell copies of the Software, and to permit persons to whom
#@HDR@	the Software is furnished to do so, subject to the following
#@HDR@	conditions:
#@HDR@	
#@HDR@	The above copyright notice and this permission notice shall be
#@HDR@	included in all copies or substantial portions of the Software.
#@HDR@	
#@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
#@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
#@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
#@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#@HDR@	OTHER DEALINGS IN THE SOFTWARE.
#
#hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
########################################################################
#doc#	Trivial program SShot written in Perl
########################################################################
#
#########################################################################
#       SShot implemented in Perl by Chris Caldwell 11/03/2022		#
#	Tested with perl v5.34.1 built for x86_64-linux-thread-multi	#
#########################################################################

use strict;

#########################################################################
#       Space over distance spaces and print given string.              #
#########################################################################
sub redraw_positions
    {
    my( $distance, $object_text ) = @_;
    print "] ", " "x$distance, $object_text, "\n";
    }

#########################################################################
#       Main                                                            #
#########################################################################

my $spaceship_distance = 10 + int( rand(65) );

while( $spaceship_distance > 0 )
    {
    redraw_positions( $spaceship_distance, "*" );
    print "Enter new shot distance: ";
    my $shot_distance = <STDIN>;
    chomp( $shot_distance );

    if( $shot_distance !~ /^\d+$/ || $shot_distance<1 || $shot_distance>75 )
	{ print "You must enter an integer between 1 and 75.\n"; }

    elsif( $shot_distance == $spaceship_distance )
    	{
        redraw_positions( $spaceship_distance, "<<Kaboom>>" );
        print("Spaceship destroyed.  You win.\n");
        $spaceship_distance = -1;
	}
    else
	{
	redraw_positions( $shot_distance, "." );
	$spaceship_distance -= ( 2 + int(rand(4) ) );
	if( $spaceship_distance <= 0 )
	    {
	    redraw_positions( 1, "<<Kaboom>>" );
	    print("Spaceship has collided with you.  You lose.\n");
	    }
	}
    }

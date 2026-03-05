#!/usr/bin/ruby
#
#indx#	sshot.ruby - Trivial program SShot written in Ruby
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
#doc#	Trivial program SShot written in Ruby
########################################################################

#########################################################################
#       SShot implemented in Ruby by Chris Caldwell 11/03/2022
#	Tested with ruby 3.1.2p20 (2022-04-12 rev 4491bb740a) [x86_64-linux]
#########################################################################

#########################################################################
#       Space over distance spaces and print given string.              #
#########################################################################

def redraw_positions( distance, object_text )
    print "] "
    while distance > 0
    	print " "
	distance = distance - 1
    end
    puts object_text
end

#########################################################################
#       Main                                                            #
#########################################################################

spaceship_distance = rand(10..75)

while( spaceship_distance > 0 )
    redraw_positions( spaceship_distance, "*" )
    print "Enter new shot distance: "
    STDOUT.flush()
    shot_distance = STDIN.gets.strip()

    #if( $shot_distance !~ /^\d+$/ || $shot_distance<1 || $shot_distance>75 )
    shot_distance = Integer( shot_distance )
    if( shot_distance < 1 || shot_distance > 75 )
	puts "You must enter an integer between 1 and 75."
    elsif( shot_distance == spaceship_distance )
        redraw_positions( spaceship_distance, "<<Kaboom>>" )
        puts "Spaceship destroyed.  You win."
	spaceship_distance = -1
    else
	redraw_positions( shot_distance, "." )
	spaceship_distance -= rand( 5 .. 15 )
	if( spaceship_distance <= 0 )
	    redraw_positions( 1, "<<Kaboom>>" )
	    puts "Spaceship has collided with you.  You lose."
	end
    end
end

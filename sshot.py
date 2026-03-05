#!/usr/bin/python
#
#indx#	sshot.py - Trivial program SShot written in Python
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
#doc#	Trivial program SShot written in Python
########################################################################
#
#########################################################################
#   SShot implemented in Python by Chris Caldwell 11/03/2022            #
#	Tested with Python 3.10.7 (Fedora Core 36)                          #
#########################################################################

import random

#########################################################################
#       Space over distance spaces and print given string.              #
#########################################################################
def redraw_positions( distance, object_text ):
    print( "]", end="" )
    for i in range( 0, distance ):
        print( " ", end="" )
    print(object_text)

#########################################################################
#       Main                                                            #
#########################################################################

spaceship_distance = random.randint( 10, 75 )

while( 1 ):
    redraw_positions( spaceship_distance, "*" )
    shot_distance_input = input("Enter new shot distance: ")
    if( not shot_distance_input.isdigit() ):
        print("You must enter an integer between 1 and 75.")
        continue

    shot_distance = int(shot_distance_input)
    if( shot_distance < 1 or shot_distance > 75 ):
        print("Your distance must be an integer from 1 to 75.")
        continue

    if( shot_distance == spaceship_distance ):
        redraw_positions( spaceship_distance, "<<Kaboom>>" )
        print("Spaceship destroyed.  You win.")
        break

    redraw_positions( shot_distance, "." )
    spaceship_distance -= random.randint( 2, 6 )
    if( spaceship_distance <= 0 ):
        redraw_positions( 1, "<<Kaboom>>" )
        print("Spaceship has collided with you.  You lose.")
        break

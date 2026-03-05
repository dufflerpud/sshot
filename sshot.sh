#!/bin/bash
#
#indx#	sshot.sh - Trivial program SShot written in Bourne-Shell/BASH
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
#doc#	Trivial program SShot written in Bourne-Shell/BASH
########################################################################
#########################################################################
#       SShot implemented in Bourne Shell by Chris Caldwell 11/03/2022
#	Tested with GNU bash, version 5.2.2(1)-release (x86_64-redhat-linux-gnu)
#########################################################################

#########################################################################
#       Space over distance spaces and print given string.              #
#########################################################################
redraw_positions()
    {
    distance="$1";
    object_text="$2";

    echo -n "] "
    while [ $distance -gt 0 ] ; do
        echo -n " "
	distance=`expr $distance - 1`
    done
    echo "$object_text"
    }

#########################################################################
#       Main                                                            #
#########################################################################

spaceship_distance=`expr 10 + $RANDOM % 65`

while [ $spaceship_distance -gt 0 ] ; do
    redraw_positions $spaceship_distance "*"
    echo -n "Enter new shot distance: "
    if read shot_distance; then

	if [ "$shot_distance" -lt 1 -o "$shot_distance" -gt 75 ]; then
	    echo "You must enter an integer between 1 and 75."

	elif [ "$shot_distance" -eq "$spaceship_distance" ]; then
	    redraw_positions $spaceship_distance "<<Kaboom>>"
	    echo "Spaceship destroyed.  You win."
	    spaceship_distance=-1

	else
	    redraw_positions "$shot_distance" "."
	    spaceship_distance=`expr $spaceship_distance - 2 - $RANDOM % 5`
	    if [ "$spaceship_distance" -le 0 ]; then
		redraw_positions 1 "<<Kaboom>>"
		echo "Spaceship has collided with you.  You lose."
	    fi
	fi
    else
        break
    fi
done

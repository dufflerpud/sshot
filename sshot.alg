#!/usr/bin/a68g --script #
#
#indx#	sshot.alg - Trivial program SShot written in Algol-68
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
#doc#	Trivial program SShot written in Algol-68
########################################################################

#/////////////////////////////////////////////////////////////////////////#
#//	SShot implemented in Algol 68 by Chris Caldwell 11/03/2022 	//#
#//	Tested on algol68g-tiny-2.8.4-18a.rhel6.9+rhel7.5.x86_64	//#
#/////////////////////////////////////////////////////////////////////////#

#/////////////////////////////////////////////////////////////////////////#
#//       Space over distance spaces and print given string.            //#
#/////////////////////////////////////////////////////////////////////////#
    PROC redraw_positions = ( INT distance, STRING object_text ) VOID:
	BEGIN
	print ("]");
	FOR i FROM 1 TO distance DO
	    print (" ")
	OD;
	print (( object_text, new line ))
	END;

#/////////////////////////////////////////////////////////////////////////#
#//       Main                                                          //#
#/////////////////////////////////////////////////////////////////////////#

    INT spaceship_distance;
    INT shot_distance;

    spaceship_distance := ENTIER(10.0 + random*65.0);

    WHILE spaceship_distance > 0 DO
	redraw_positions( spaceship_distance, "*" );
	print ("Enter new shot distance: ");
	shot_distance := read int;

	IF shot_distance < 1 OR shot_distance > 75 THEN
	    print (("You must enter an integer between 1 and 75.",new line))

	ELIF shot_distance = spaceship_distance THEN
	    redraw_positions( spaceship_distance, "<<Kaboom>>" );
	    print (("Spaceship destroyed.  You win.",new line));
	    spaceship_distance := -1
	ELSE
	    redraw_positions( shot_distance, "." );
	    spaceship_distance := spaceship_distance - ENTIER( 5.0 + random*10.0 );
	    IF spaceship_distance <= 0 THEN
		redraw_positions( 1, "<<Kaboom>>" );
		print (("Spaceship has collided with you.  You lose.",new line));
		spaceship_distance := -1
	    FI
	FI
    OD

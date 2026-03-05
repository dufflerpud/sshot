#!/bin/make test-sshot_f

Cindx#	sshot.f - Trivial program SShot written in Fortran
C@HDR@	$Id$
C@HDR@
C@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
C@HDR@
C@HDR@	Permission is hereby granted, free of charge, to any person
C@HDR@	obtaining a copy of this software and associated documentation
C@HDR@	files (the "Software"), to deal in the Software without
C@HDR@	restriction, including without limitation the rights to use,
C@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
C@HDR@	sell copies of the Software, and to permit persons to whom
C@HDR@	the Software is furnished to do so, subject to the following
C@HDR@	conditions:
C@HDR@	
C@HDR@	The above copyright notice and this permission notice shall be
C@HDR@	included in all copies or substantial portions of the Software.
C@HDR@	
C@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
C@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
C@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
C@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
C@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
C@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
C@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
C@HDR@	OTHER DEALINGS IN THE SOFTWARE.
C
Chist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
C------------------------------------------------------------------------
Cdoc#	Trivial program SShot written in Fortran
C------------------------------------------------------------------------
C       SShot implemented in Fortran by Chris Caldwell 11/03/2022
C	Tested with gcc version 12.2.1 20220819 (Red Hat 12.2.1-2) (GCC)

C########################################################################
C	Return a random integer in a particular range
C########################################################################
	INTEGER FUNCTION rand_range( mn, mx )
	INTEGER mn, mx
	REAL rnd
	CALL random_number( rnd )
	rand_range = (rnd*(mx-mn)) + mn
	RETURN
	END

C########################################################################
C	Fortran output is clumsy.  This is slightly more readable.	#
C########################################################################
	SUBROUTINE puts( newline, str )
	LOGICAL newline
	CHARACTER *(*)str
	IF( newline ) GOTO 10
	WRITE( *, 50, ADVANCE='NO' ) str
	RETURN

10	CONTINUE
	WRITE( *, 50 ) str
	RETURN

50	FORMAT(a)
	END

C########################################################################
C       Space over distance spaces and print given string.              #
C########################################################################
	SUBROUTINE redraw_positions( distance, object_text )
	INTEGER DISTANCE
	INTEGER COUNTER
	CHARACTER *(*)object_text

	CALL puts( .FALSE., "]" )

	DO 300 COUNTER=1, DISTANCE
	    CALL puts( .FALSE., " " )
300	CONTINUE

	CALL puts( .TRUE., object_text )
	RETURN
	END

C########################################################################
C       Main                                                            #
C########################################################################

	INTEGER spaceship_distance
	INTEGER shot_distance
	INTEGER rand_range
	
	spaceship_distance = rand_range( 10, 75 )

1000	CONTINUE
	    IF( spaceship_distance .LE. 0 ) GOTO 3000
	    CALL redraw_positions( spaceship_distance, "*" )
	    CALL puts( .FALSE., "Enter new shot distance: ")
	    READ( 5, * ) shot_distance

	    IF(shot_distance .GE. 1 .AND. shot_distance .LE. 75) GOTO 1010
	    	CALL puts(.TRUE., "You must enter an int between 1 and 75.")
		GOTO 1000

1010	    CONTINUE
	    IF( shot_distance .NE. spaceship_distance ) GOTO 1020
		CALL redraw_positions( spaceship_distance, ">>Kaboom<<" )
		CALL puts(.TRUE.,"Spaceship destroyed.  You win.")
		spaceship_distance = -1
		GOTO 2000

1020	    CONTINUE
	    CALL redraw_positions( shot_distance, "." )
	    spaceship_distance = spaceship_distance - rand_range( 5, 15 )
	    IF( spaceship_distance .GT. 0 ) GOTO 2000
		CALL redraw_positions( 1, "<<Kaboom>>" )
		CALL PUTS(.TRUE.,"Spaceship has collided with you.  You lose.")
		spaceship_distance = -1
		GOTO 2000

2000	    CONTINUE
	    GOTO 1000

3000	CONTINUE
	STOP
	END

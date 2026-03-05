#!/usr/local/bin/yabasic
//
//indx#	sshot.bas - Trivial program SShot written in YA-Basic
//@HDR@	$Id$
//@HDR@
//@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
//@HDR@
//@HDR@	Permission is hereby granted, free of charge, to any person
//@HDR@	obtaining a copy of this software and associated documentation
//@HDR@	files (the "Software"), to deal in the Software without
//@HDR@	restriction, including without limitation the rights to use,
//@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
//@HDR@	sell copies of the Software, and to permit persons to whom
//@HDR@	the Software is furnished to do so, subject to the following
//@HDR@	conditions:
//@HDR@	
//@HDR@	The above copyright notice and this permission notice shall be
//@HDR@	included in all copies or substantial portions of the Software.
//@HDR@	
//@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
//@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
//@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//@HDR@	OTHER DEALINGS IN THE SOFTWARE.
//
//hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
//#######################################################################
//doc#	Trivial program SShot written in YA-Basic
//#######################################################################
0200 	 
0300 	 REM    SShot implemented in Basic by Chris Caldwell 11/03/2022
0400 	 REM	Tested with yabasic 2.90.2, built on x86_64-unknown-linux-gnu
0500 	 
0600 	 REM ########################################################################
0700 	 REM        Main                                                            #
0800 	 REM ########################################################################
0900 	 
1000 	 	LET spaceship_distance = FLOOR( RAN(65) ) + 10
1100 	 	LET shot_distance = 0
1200 	 
1300 	 	REM Top of loop
1400 	 	    IF( spaceship_distance <= 0 ) GOTO 5000
1500 	 	    LET redraw_positions_string$ = "*"
1600 	 	    LET redraw_positions_distance = spaceship_distance
1700 	 	    GOSUB 5400
1800 	 
1900 	 	    INPUT "Enter new shot distance: " shot_distance
2000 	 
2100 	 	    IF(shot_distance >= 1 AND shot_distance <= 75) GOTO 2500
2200 	 	    	PRINT "You must enter an integer between 1 and 75."
2300 	 		GOTO 1300
2400 	 
2500 	     	REM Else
2600 	 	    IF( shot_distance <> spaceship_distance ) GOTO 3400
2700 	 		LET redraw_positions_distance = spaceship_distance
2800 	 		LET redraw_positions_string$ = ">>Kaboom<<"
2900 	 		GOSUB 5400
3000 	 		PRINT "Spaceship destroyed.  You win."
3100 	 		LET spaceship_distance = -1
3200 	 		GOTO 1300
3300 	 
3400 	     	REM Else
3500 	 	    LET redraw_positions_distance = shot_distance
3600 	 	    LET redraw_positions_string$ = "."
3700 	 	    GOSUB 5400
3800 	 	    LET spaceship_distance = spaceship_distance - (5 + FLOOR(RAN(10)))
3900 	 	    IF( spaceship_distance > 0 ) GOTO 4700
4000 	 		LET redraw_positions_distance = 1
4100 	 		LET redraw_positions_string$ = "<<Kaboom>>"
4200 	 		GOSUB 5400
4300 	 		PRINT "Spaceship has collided with you.  You lose."
4400 	 		LET spaceship_distance = -1
4500 	 		GOTO 4700
4600 	 
4700 	 	    REM End of loop
4800 	 	    GOTO 1300
4900 	 
5000 	 	REM End of program
5200 	 	END
5300 	 
5400 	 REM ########################################################################
5500 	 REM        Space over distance spaces and print given string.              #
5600 	 REM ########################################################################
5700 	 REM redraw_positions( redraw_positions_distance,redraw_positions_string$ )
5800 	 	PRINT "]";
5900 	 	FOR counter = 1 to redraw_positions_distance
6000 	 	    print " ";
6100 	 	NEXT counter
6200 	 	PRINT redraw_positions_string$
6300 	 	RETURN

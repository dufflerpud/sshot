#!/bin/make test-sshot_cob
        *>#indx#	sshot.cob - Trivial program SShot written in Cobol
        *>#@HDR@	$Id$
        *>#@HDR@
        *>#@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
        *>#@HDR@
        *>#@HDR@	Permission is hereby granted, free of charge, to any person
        *>#@HDR@	obtaining a copy of this software and associated documentation
        *>#@HDR@	files (the "Software"), to deal in the Software without
        *>#@HDR@	restriction, including without limitation the rights to use,
        *>#@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
        *>#@HDR@	sell copies of the Software, and to permit persons to whom
        *>#@HDR@	the Software is furnished to do so, subject to the following
        *>#@HDR@	conditions:
        *>#@HDR@	
        *>#@HDR@	The above copyright notice and this permission notice shall be
        *>#@HDR@	included in all copies or substantial portions of the Software.
        *>#@HDR@	
        *>#@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
        *>#@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
        *>#@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
        *>#@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
        *>#@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
        *>#@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
        *>#@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
        *>#@HDR@	OTHER DEALINGS IN THE SOFTWARE.
        *>#
        *>#hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
        *>########################################################################
        *>#doc#	Trivial program SShot written in Cobol
        *>########################################################################
        *>////////////////////////////////////////////////////////////////////////
        *>      SShot implemented in Cobol by Chris Caldwell 11/03/2022         //
        *>      Tested with cobc (GnuCOBOL) 3.1.2.0                             //
        *>////////////////////////////////////////////////////////////////////////

        IDENTIFICATION DIVISION.
        PROGRAM-ID. SSHOT.

        DATA DIVISION.
         WORKING-STORAGE SECTION.
          01 targ_dist          PIC 9(9) VALUE 75.
          01 shot_dist          PIC 9(9) VALUE 0.
          01 so_counter         PIC 9(9) VALUE 0.
          01 so_text            PIC A(30).

        PROCEDURE DIVISION.
	 *>////////////////////////////////////////////////////////////////////////
	 *>       Main                                                           //
	 *>////////////////////////////////////////////////////////////////////////
	 Main.
	  COMPUTE targ_dist = 10 + 65 * FUNCTION RANDOM.
	  PERFORM UNTIL targ_dist <= 0
	   MOVE targ_dist TO so_counter
	   MOVE "*" TO so_text
	   PERFORM redraw_positions

	   DISPLAY "Enter new shot distance: " WITH NO ADVANCING
	   ACCEPT shot_dist

	   IF shot_dist < 1 OR shot_dist > 75 THEN
	    DISPLAY "You must enter an integer between 1 and 75."
	   ELSE
	    IF shot_dist = targ_dist THEN
	     MOVE targ_dist TO so_counter
	     MOVE "<<Kaboom>>" TO so_text
	     PERFORM redraw_positions
	     DISPLAY "Spaceship destroyed.  You win."
	     MOVE 0 TO targ_dist
	    ELSE
	     MOVE shot_dist TO so_counter
	     MOVE "." TO so_text
	     PERFORM redraw_positions
	     COMPUTE targ_dist = targ_dist - 5 - 10 * FUNCTION RANDOM
	     IF targ_dist = 0 THEN
	      MOVE targ_dist to so_counter
	      MOVE "<<Kaboom>>" to so_text
	      PERFORM redraw_positions
	      DISPLAY "Spaceship has collided with you.  You lose."
	     END-IF
	    END-IF
	   END-IF
	  END-PERFORM
	  STOP RUN.

	*>////////////////////////////////////////////////////////////////////////
	*>       Space over distance spaces and print given string.             //
	*>////////////////////////////////////////////////////////////////////////
	redraw_positions.
	 DISPLAY "]" WITH NO ADVANCING
	 PERFORM UNTIL so_counter <= 0
	  DISPLAY " " WITH NO ADVANCING
	  COMPUTE so_counter = so_counter - 1
	 END-PERFORM
	 DISPLAY so_text.

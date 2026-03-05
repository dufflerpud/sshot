#!/bin/gcl -f
;/
;/indx#	sshot.lsp - Trivial program SShot written in Lisp
;/@HDR@	$Id$
;/@HDR@
;/@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
;/@HDR@
;/@HDR@	Permission is hereby granted, free of charge, to any person
;/@HDR@	obtaining a copy of this software and associated documentation
;/@HDR@	files (the "Software"), to deal in the Software without
;/@HDR@	restriction, including without limitation the rights to use,
;/@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
;/@HDR@	sell copies of the Software, and to permit persons to whom
;/@HDR@	the Software is furnished to do so, subject to the following
;/@HDR@	conditions:
;/@HDR@	
;/@HDR@	The above copyright notice and this permission notice shall be
;/@HDR@	included in all copies or substantial portions of the Software.
;/@HDR@	
;/@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
;/@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
;/@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
;/@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;/@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;/@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;/@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;/@HDR@	OTHER DEALINGS IN THE SOFTWARE.
;/
;/hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
;/#######################################################################
;/doc#	Trivial program SShot written in Lisp
;/#######################################################################
;/////////////////////////////////////////////////////////////////////////
;/	SShot implemented in GNU LISP by Chris Caldwell 11/03/2022	//
;/	Tested with GCL (GNU Common Lisp) 2.6.12			//
;/	Note that this implementation really doesn't take any		//
;/	advantage of the real features of Lisp.				//
;/////////////////////////////////////////////////////////////////////////

(defun randrange (minv maxv)
    (floor (+ minv (random (- maxv minv))))
)

;/////////////////////////////////////////////////////////////////////////
;       Space over distance spaces and print given string.		//
;/////////////////////////////////////////////////////////////////////////
(defun redraw_positions ( distance object_text )
    (block redraw_positions_block
        (format t "]")
	(loop for counter from 1 to distance
	    do (format t " ")
	)
        (format t object_text)
	(terpri)
    )
)

;;////////////////////////////////////////////////////////////////////////
;;       Main								//
;;////////////////////////////////////////////////////////////////////////
(defun sshot ()
    (block sshot_block
        (setq spaceship_distance (randrange 10 75))

	(loop named spaceship_distance_loop do
	    (cond
	        (
		    (<= spaceship_distance 0)
		    (return-from spaceship_distance_loop)
		)
		(
		    (= 1 1)
		    (block spaceship_distance_block
			(redraw_positions spaceship_distance "*" )
			(format t "Enter new shot distance: ")
			(setq shot_distance (parse-integer (read-line)))

			(cond
			    (   ; Check if shot_distance between 1 and 75
			        (or (< shot_distance 1)(> shot_distance 75))
				(format t "Your answer must be between 1 and 75")
				(terpri)
			    )
			    (   ; Range is good, check if shot hit spaceship
				(= shot_distance spaceship_distance)
				(block player_wins
				    (redraw_positions spaceship_distance ">>Kaboom<<")
				    (format t "Spaceship destroyed.  You win.")
				    (terpri)
				    (setq spaceship_distance 0)
				)
			    )
			    (   ; Didn't hit the spaceship, show miss
			    	(= 1 1)
				(block player_misses
				    (redraw_positions shot_distance ".")
				    (setq spaceship_distance
					(- spaceship_distance (randrange 5 15))
				    )   ; setq
				    (cond	; Check if spaceship hit player
					(
					    (<= spaceship_distance 0)
					    (block player_loses
						(setq spaceship_distance 0)
						(redraw_positions spaceship_distance "<<Kaboom>>")
						(format t "Spaceship has collided with you.  You lose.")
						(terpri)
					    )
					)   ; block player_loses
				    )   ; conditional spaceship_distance
				)   ; block player_misses
			    )   ; player did not win
			)   ; conditional answer range
		    )    ; block_spaceship_distance
		)   ; else spaceship_distance
	    )	; conditional spaceship_distance
	)   ; loop spaceship_distance_loop
    )	; block sshot_block
)   ; function definition

(sshot)
(quit)

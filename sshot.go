//bin/go run $0 $@; exit
package main
/*
#indx#	sshot.go - Trivial program SShot written in Go
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
#doc#	Trivial program SShot written in Go
########################################################################
*/
/*//////////////////////////////////////////////////////////////////////*/
/*	SShot implemented in Go (Golang) by Chris Caldwell 11/03/2022	*/
/*	Tested with go version go1.18.7 linux/amd64			*/
/*//////////////////////////////////////////////////////////////////////*/

import (
    "fmt"
    "math/rand"
)

/*//////////////////////////////////////////////////////////////////////*/
/*       Space over distance spaces and print given string.		*/
/*//////////////////////////////////////////////////////////////////////*/
func redraw_positions( distance int, object_text string ) {
    fmt.Printf("]%*s%s\n",distance,"",object_text);
}

/*//////////////////////////////////////////////////////////////////////*/
/*       Main								*/
/*//////////////////////////////////////////////////////////////////////*/
func main() {
    var spaceship_distance int = 10 + rand.Intn(65);

    for spaceship_distance > 0 {
	var shot_distance int;
	redraw_positions( spaceship_distance, "*" );
	fmt.Printf("Enter new shot distance: ");
	fmt.Scanf("%d",&shot_distance);

	if shot_distance<1 || shot_distance>75 {
	    fmt.Println("You must enter an integer between 1 and 75.");
	} else if shot_distance == spaceship_distance {
	    redraw_positions( spaceship_distance, "<<Kaboom>>" );
	    fmt.Println("Spaceship destroyed.  You win.");
	    spaceship_distance = -1;	// Causes loop to exit
	} else {
	    redraw_positions( shot_distance, "." );
	    spaceship_distance -= ( 5 + rand.Intn(10) );
	    if spaceship_distance <= 0 {
		redraw_positions( 1, "<<Kaboom>>" );
		fmt.Println("Spaceship has collided with you.  You lose.");
	    }
	}
    }
}

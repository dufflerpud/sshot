#!/bin/sh
exec scala "$0" "$@"
!#
// indx#	sshot.scala - Trivial program SShot written in Scala
// @HDR@	$Id$
// @HDR@
// @HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
// @HDR@
// @HDR@	Permission is hereby granted, free of charge, to any person
// @HDR@	obtaining a copy of this software and associated documentation
// @HDR@	files (the "Software"), to deal in the Software without
// @HDR@	restriction, including without limitation the rights to use,
// @HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
// @HDR@	sell copies of the Software, and to permit persons to whom
// @HDR@	the Software is furnished to do so, subject to the following
// @HDR@	conditions:
// @HDR@	
// @HDR@	The above copyright notice and this permission notice shall be
// @HDR@	included in all copies or substantial portions of the Software.
// @HDR@	
// @HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
// @HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// @HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
// @HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// @HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// @HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// @HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// @HDR@	OTHER DEALINGS IN THE SOFTWARE.
// 
// hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
// #######################################################################
// doc#	Trivial program SShot written in Scala
// #######################################################################
/////////////////////////////////////////////////////////////////////////
//	SShot implemented in Scala by Chris Caldwell 11/03/2022
//	Tested with scala-latest-openjdk-1:19.0.0.0.36-3.rolling.fc36.x86_64
/////////////////////////////////////////////////////////////////////////

import scala.util.Random;
									
object Main
    {
    /////////////////////////////////////////////////////////////////////////
    //       Space over distance spaces and print given string.
    /////////////////////////////////////////////////////////////////////////
    def redraw_positions( distance:Int, object_text:String ): Unit =
	{
	var counter:Int = distance;
	System.out.printf("]");
	while( counter > 0 )
	    {
	    System.out.printf(" ");
	    counter = counter - 1;
	    }
	println(object_text);
	}

    /////////////////////////////////////////////////////////////////////////
    //       Main
    /////////////////////////////////////////////////////////////////////////
    def main( args: Array[String]): Unit =
	{
	val rand = new scala.util.Random;
	// val rand:scala.util.Random = scala.util.Random@433d9688;

	var spaceship_distance:Int = 10 + rand.nextInt(65);

	while( spaceship_distance > 0 )
	    {
	    var shot_distance:Int = 0;
	    redraw_positions( spaceship_distance, "*" );
	    System.out.printf("Enter new shot distance: ");
	    shot_distance = Integer.parseInt(System.console().readLine());

	    if( shot_distance<1 || shot_distance>75 )
		{ println("You must enter an integer between 1 and 75."); }

	    else if( shot_distance == spaceship_distance )
		{
		redraw_positions( spaceship_distance, "<<Kaboom>>" );
		println("Spaceship destroyed.  You win.");
		spaceship_distance = -1;	// Causes loop to exit
		}
	    else
		{
		redraw_positions( shot_distance, "." );
		spaceship_distance = spaceship_distance - ( 2 + rand.nextInt(4) );
		if( spaceship_distance <= 0 )
		    {
		    redraw_positions( 1, "<<Kaboom>>" );
		    println("Spaceship has collided with you.  You lose.");
		    }
		}
	    }
	}
    }

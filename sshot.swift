#!/bin/swift
//indx#	sshot.swift - Trivial program SShot written in Swift
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
//doc#	Trivial program SShot written in Swift
//#######################################################################
/////////////////////////////////////////////////////////////////////////
//  SShot implemented in Swift by Chris Caldwell 11/03/2022
//  Tested with java-latest-openjdk-1:19.0.0.0.36-3.rolling.fc36.x86_64
/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
//  Space over distance spaces and print given string.
/////////////////////////////////////////////////////////////////////////
func redraw_positions( distance:Int, object_text:String )
    {
    var counter:Int = distance;
    print("]", terminator:"");
    while( counter > 0 )
	{
	print(" ", terminator:"");
	counter -= 1;
	}
    print(object_text);
    }

/////////////////////////////////////////////////////////////////////////
//       Main
/////////////////////////////////////////////////////////////////////////
var spaceship_distance:Int = Int.random( in: 10..<75 );

while( spaceship_distance > 0 )
    {
    var shot_distance:Int = 0;
    redraw_positions( distance:spaceship_distance, object_text:"*" );
    print("Enter new shot distance: ", terminator:"");
    if let input = readLine()
	{
	if let number = Int( input )
	    {
	    shot_distance = number
	    }
	}

    if( shot_distance<1 || shot_distance>75 )
	{ print("You must enter an integer between 1 and 75."); }

    else if( shot_distance == spaceship_distance )
	{
	redraw_positions( distance:spaceship_distance, object_text:"<<Kaboom>>" );
	print("Spaceship destroyed.  You win.");
	spaceship_distance = -1;	// Causes loop to exit
	}
    else
	{
	redraw_positions( distance:shot_distance, object_text:"." );
	spaceship_distance -= ( Int.random( in:5..<15 ) );
	if( spaceship_distance <= 0 )
	    {
	    redraw_positions( distance:1, object_text:"<<Kaboom>>" );
	    print("Spaceship has collided with you.  You lose.");
	    }
	}
    }

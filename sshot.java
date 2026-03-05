#!/bin/make test-sshot_java
#!/usr/bin/java --source 11

//indx#	sshot.java - Trivial program SShot written in java
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
//doc#	Trivial program SShot written in java
//#######################################################################
/////////////////////////////////////////////////////////////////////////
//	SShot implemented in Java by Chris Caldwell 11/03/2022
//	Tested with openjdk version "11.0.17" 2022-10-18,
//	OpenJDK Runtime Environment (Red_Hat-11.0.17.0.8-2.fc36) (build 11.0.17+8),
//	& OpenJDK 64-Bit Server VM (Red_Hat-11.0.17.0.8-2.fc36) (build 11.0.17+8, mixed mode, sharing)
//	Which under Fedora required:
//	    sudo dnf -y install java-11 java-11-openjdk java-11-openjdk-devel
//	    sudo alternatives --config java		and selecting -11
/////////////////////////////////////////////////////////////////////////

import java.util.Random;
									
public class sshot
    {
    /////////////////////////////////////////////////////////////////////////
    //       Space over distance spaces and print given string.
    /////////////////////////////////////////////////////////////////////////
    static void redraw_positions( int distance, String object_text )
	{
	System.out.printf("]");
	while( distance-- > 0 )
	    { System.out.printf(" "); }
	System.out.printf("%s\n",object_text);
	}

    /////////////////////////////////////////////////////////////////////////
    //       Main
    /////////////////////////////////////////////////////////////////////////
    public static void main( String[] args )
	{
	Random rand = new Random();
	int spaceship_distance = 10 + rand.nextInt(65);

	while( spaceship_distance > 0 )
	    {
	    int shot_distance;
	    redraw_positions( spaceship_distance, "*" );
	    System.out.printf("Enter new shot distance: ");
	    shot_distance = Integer.parseInt(System.console().readLine());

	    if( shot_distance<1 || shot_distance>75 )
		{ System.out.printf("You must enter an integer between 1 and 75.\n"); }

	    else if( shot_distance == spaceship_distance )
		{
		redraw_positions( spaceship_distance, "<<Kaboom>>" );
		System.out.printf("Spaceship destroyed.  You win.\n");
		spaceship_distance = -1;	// Causes loop to exit
		}
	    else
		{
		redraw_positions( shot_distance, "." );
		spaceship_distance -= ( 2 + rand.nextInt(4) );
		if( spaceship_distance <= 0 )
		    {
		    redraw_positions( 1, "<<Kaboom>>" );
		    System.out.printf("Spaceship has collided with you.  You lose.\n");
		    }
		}
	    }
	}
    }

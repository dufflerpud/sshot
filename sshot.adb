#!/bin/make test-sshot_adb
--
--indx#	sshot.adb - Trivial program SShot written in ADA
--@HDR@	$Id$
--@HDR@
--@HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
--@HDR@
--@HDR@	Permission is hereby granted, free of charge, to any person
--@HDR@	obtaining a copy of this software and associated documentation
--@HDR@	files (the "Software"), to deal in the Software without
--@HDR@	restriction, including without limitation the rights to use,
--@HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
--@HDR@	sell copies of the Software, and to permit persons to whom
--@HDR@	the Software is furnished to do so, subject to the following
--@HDR@	conditions:
--@HDR@	
--@HDR@	The above copyright notice and this permission notice shall be
--@HDR@	included in all copies or substantial portions of the Software.
--@HDR@	
--@HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
--@HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
--@HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
--@HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
--@HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
--@HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
--@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
--@HDR@	OTHER DEALINGS IN THE SOFTWARE.
--
--hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
--#######################################################################
--doc#	Trivial program SShot written in ADA
--#######################################################################
--------------------------------------------------------------------------
--	SShot implemented in ADA by Chris Caldwell 11/03/2022		--
--	Tested on gcc-ada GNATBIND 12.2.1 20220819			--
--------------------------------------------------------------------------

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.numerics.discrete_random;

---------------------------------------------------------------------------
--       Main                                                            --
---------------------------------------------------------------------------
procedure sshot_adb is
    subtype Random_Range is Integer range 1..100000;
    package R is new
        Ada.Numerics.Discrete_Random( Random_Range );
    use R;

    G: Generator;

    shot_distance:Integer;
    spaceship_distance:Integer := 10 + Random(G) mod 65;
									
    -----------------------------------------------------------------------
    --       Space over distance spaces and print given String.          --
    -----------------------------------------------------------------------
    procedure redraw_positions ( distance:Integer; object_text:String ) is
    begin
	Put("]");
	for counter in 1 .. distance loop
	    Put(" ");
	end loop;
	Put_Line( object_text );
    end redraw_positions;

begin
    while spaceship_distance > 0 loop
	redraw_positions( spaceship_distance, "*" );
	Put("Enter new shot distance: ");
	shot_distance := Integer'Value(Get_Line);

	if (shot_distance<1) or (shot_distance>75) then
	    Put_Line ("You must enter an Integer between 1 and 75.");

	else
	    if shot_distance = spaceship_distance then
		redraw_positions( spaceship_distance, "<<Kaboom>>" );
		Put_Line ("Spaceship destroyed.  You win.");
		spaceship_distance := -1;
	    else
		redraw_positions( shot_distance, "." );
		spaceship_distance := spaceship_distance - ( 5 + Random(G) mod 10 );
		if spaceship_distance <= 0 then
		    redraw_positions( 1, "<<Kaboom>>" );
		    Put_Line ("Spaceship has collided with you.  You lose.");
		end if;
	    end if;
	end if;
    end loop;
end sshot_adb;

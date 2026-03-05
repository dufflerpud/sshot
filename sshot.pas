#!/bin/make test-sshot_pas
(*
#indx#	sshot.pas - Trivial program SShot written in Pascal
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
#doc#	Trivial program SShot written in Pascal
########################################################################*)
program sshot;

(************************************************************************)
(*	SShot implemented in Pascal by Chris Caldwell 11/03/2022 	*)
(*	Tested on Free Pascal Compiler v3.2.2 [2022/03/16] for x86_64	*)
(************************************************************************)

var
    spaceship_distance: integer;
    shot_distance: integer;
									
(*************************************************************************)
(*       Space over distance spaces and print given string.              *)
(*************************************************************************)
procedure redraw_positions( distance: integer; object_text: string );
    begin
    write(']');
    while( distance > 0 ) do
	begin
	distance := distance - 1;
	write(' ');
	end;
    writeln( object_text );
    end;

(*************************************************************************)
(*       Main                                                            *)
(*************************************************************************)
begin

spaceship_distance := 10 + random(65);

while( spaceship_distance > 0 ) do
    begin
    redraw_positions( spaceship_distance, '*' );
    write('Enter new shot distance: ');
    flush(stdout);
    read(shot_distance);

    if( (shot_distance<1) or (shot_distance>75) ) then
	writeln('You must enter an integer between 1 and 75.')

    else
	begin
	if( shot_distance = spaceship_distance ) then
	    begin
	    redraw_positions( spaceship_distance, '<<Kaboom>>' );
	    writeln('Spaceship destroyed.  You win.');
	    spaceship_distance := -1;
	    end
	else
	    begin
	    redraw_positions( shot_distance, '.' );
	    spaceship_distance := spaceship_distance - ( 2 + random(4) );
	    if( spaceship_distance <= 0 ) then
		{
		begin
		redraw_positions( 1, '<<Kaboom>>' );
		writeln('Spaceship has collided with you.  You lose.');
		end
		}
	    end
	end;
    end;
end.

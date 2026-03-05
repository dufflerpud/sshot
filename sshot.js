<html><head><script>
//
//indx#	sshot.js - Trivial program SShot written in Javascript
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
//@HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
//@HDR@	OR OTHER DEALINGS IN THE SOFTWARE.
//
//hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
////////////////////////////////////////////////////////////////////////
//doc#	Trivial program SShot written in Javascript
////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
//	SShot implemented in Javascript by Chris Caldwell 11/03/2022	//
//	Tested on Firefox 105.0.2 (64-bit)				//
//////////////////////////////////////////////////////////////////////////

var spaceship_distance;

//////////////////////////////////////////////////////////////////////////
//	Return an integer between mn and mx.				//
//////////////////////////////////////////////////////////////////////////
function randrange( mn, mx )
    {
    return Math.floor( Math.random()*(mx-mn) ) + mn;
    }

//////////////////////////////////////////////////////////////////////////
//	Space over distance spaces and print given string.		//
//////////////////////////////////////////////////////////////////////////
function redraw_positions( idname, distance, text )
    {
    // alert("redraw_positions("+idname+") spaceship_distance="+spaceship_distance+" distance="+distance+" text=["+text+"]");
    var s = "]";
    while( distance-- > 0 )
        { s += "&nbsp;"; }
    s += text;
    (document.getElementById(idname)).innerHTML = s;
    }

//////////////////////////////////////////////////////////////////////////
//	Update positions of missile and spaceship.			//
//////////////////////////////////////////////////////////////////////////
function shoot( ptr )
    {
    var shot_distance = ptr.value;
    ptr.value = "";

    if( shot_distance == spaceship_distance )
	{
	redraw_positions( "missile", shot_distance, "" );
	redraw_positions( "spaceship", shot_distance, "{{KABOOM}}" );
	alert("Spaceship destroyed");
	setup();
	}
    else
	{
	redraw_positions( "missile", shot_distance, "." );
	var movesby = randrange( 5, 15 );
	spaceship_distance -= movesby;
	if( spaceship_distance > 0 )
	    { redraw_positions( "spaceship", spaceship_distance, "*" ); }
	else
	    {
	    redraw_positions( "spaceship", spaceship_distance, "((KABOOM))" );
	    alert("You have been destroyed.");
	    setup();
	    }
	}
    }

//////////////////////////////////////////////////////////////////////////
//	Setup a new game.						//
//////////////////////////////////////////////////////////////////////////
function setup()
    {
    spaceship_distance = randrange( 10, 75 );
    redraw_positions( "spaceship", spaceship_distance, "*" );
    redraw_positions( "missile", 0, "" );
    }

</script></head><body onLoad='setup();'>
<center><form><table width=100%>
    <tr><td width=100% id=spaceship>]</td></tr>
    <tr><td width=100% id=missile>]</td></tr>
    <tr><td>Distance:<input type=number size=4 min=1 max=76 onchange='shoot(this);'></td></tr>
</table></center>
</body></html>

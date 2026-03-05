#!/bin/make test-sshot_rs
//
//indx#	sshot.rs - Trivial program SShot written in Rust
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
//doc#	Trivial program SShot written in Rust
//#######################################################################
//////////////////////////////////////////////////////////////////////////
//	SShot implemented in Rust by Chris Caldwell 11/03/2022              //
//	Tested with rust-1.64.0-1.fc36.x86_64                              //
//////////////////////////////////////////////////////////////////////////
//	Oh, this is ugly.  Rust wants to be built in its own directory      //
//	which the other languages do not.  I have created a directory       //
//	called "rust" which contains crates and a .toml file for Cargo      //
//	but the main.rs is simply a simbolic link to the source file        //
//	1.rs here.  If I was more familiar with the Cargo system, I bet     //
//	I could make rand available to everyone everywhere, like std::io    //
//	but I am not and figuring it out doesn't seem like a good use of    //
//	time unless I'm actually going to create production Rust code.      //
//////////////////////////////////////////////////////////////////////////

extern crate rand;

use std::io;
use std::io::Write;
use rand::Rng;
									
//////////////////////////////////////////////////////////////////////////
//  Space over distance spaces and print given string.                  //
//////////////////////////////////////////////////////////////////////////
fn redraw_positions( distance:i32, object_text:&str ) -> ()
    {
    print!("]");
    let mut counter:i32 = distance;
    while counter > 0
        {
	counter = counter - 1;
	print!(" ");
	}
    println!( "{}", object_text );
    }

//////////////////////////////////////////////////////////////////////////
//  Main                                                                //
//////////////////////////////////////////////////////////////////////////
fn main()
    {
    let mut rng = rand::thread_rng();
    let mut spaceship_distance: i32 = rng.gen_range(10..75);

    while spaceship_distance > 0
        {
        redraw_positions( spaceship_distance, "*" );
        print!("Enter new shot distance: ");
        io::stdout().flush().unwrap();

        let mut input_line = String::new();
        io::stdin()
            .read_line( &mut input_line )
            .expect("Failed to read line");
        let shot_distance:i32 =
            input_line.trim().parse().expect("Input not an integer");

        if shot_distance<1 || shot_distance>75
            { println!("You must enter an integer between 1 and 75."); }

        else if shot_distance == spaceship_distance
            {
            redraw_positions( spaceship_distance, "<<Kaboom>>" );
            println!("Spaceship destroyed.  You win.");
            spaceship_distance = -1;	// Causes the loop to exit
            }
        else
            {
            redraw_positions( shot_distance, "." );
            spaceship_distance = spaceship_distance - rng.gen_range(5..15);
            if spaceship_distance <= 0
                {
                redraw_positions( 1, "<<Kaboom>>" );
                println!("Spaceship has collided with you.  You lose.");
                }
            }
        }
    }

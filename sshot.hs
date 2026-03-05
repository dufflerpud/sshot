#!/usr/bin/runhugs +l
-- 
-- indx#	sshot.hs - Trivial program SShot written in Haskell
-- @HDR@	$Id$
-- @HDR@
-- @HDR@	Copyright (c) 2026 Christopher Caldwell (Christopher.M.Caldwell0@gmail.com)
-- @HDR@
-- @HDR@	Permission is hereby granted, free of charge, to any person
-- @HDR@	obtaining a copy of this software and associated documentation
-- @HDR@	files (the "Software"), to deal in the Software without
-- @HDR@	restriction, including without limitation the rights to use,
-- @HDR@	copy, modify, merge, publish, distribute, sublicense, and/or
-- @HDR@	sell copies of the Software, and to permit persons to whom
-- @HDR@	the Software is furnished to do so, subject to the following
-- @HDR@	conditions:
-- @HDR@	
-- @HDR@	The above copyright notice and this permission notice shall be
-- @HDR@	included in all copies or substantial portions of the Software.
-- @HDR@	
-- @HDR@	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
-- @HDR@	KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
-- @HDR@	WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
-- @HDR@	AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
-- @HDR@	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
-- @HDR@	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- @HDR@	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- @HDR@	OTHER DEALINGS IN THE SOFTWARE.
-- 
-- hist#	2026-03-05 - Christopher.M.Caldwell0@gmail.com - Created
-- #######################################################################
-- doc#	Trivial program SShot written in Haskell
-- ########################################################################
--------------------------------------------------------------------------
--	SShot implemented in Haskell by Chris Caldwell 11/03/2022	--
--	Tested with hugs98-2006.09-43.fc36.x86_64			--
--------------------------------------------------------------------------

import System.Random
import Control.Monad(when)

--------------------------------------------------------------------------
--	Recursive way to space over.  Must be an easier way.		--
--------------------------------------------------------------------------
space_out :: Int -> IO ()
space_out 0 = putStr ""
space_out n =
    do
	putStr " "
	space_out (n-1)

--------------------------------------------------------------------------
--       Space over distance spaces and print given string.		--
--------------------------------------------------------------------------
redraw_positions :: Int -> String -> IO ()
redraw_positions distance object_text =
    do
        putStr "]"
	space_out distance
	putStrLn object_text

--------------------------------------------------------------------------
--	The "loop" of the game.						--
--	Note that we have to pass the state of the random number	--
--	generator to the next instance.					--
--------------------------------------------------------------------------
play_loop :: Int -> StdGen -> IO ()
play_loop spaceship_distance gen =
    if spaceship_distance <= 0 then
	do
	    redraw_positions spaceship_distance "<<Kaboom>>"
	    putStrLn "Spaceship has collided with you.  You lose."
    else
	do
	    redraw_positions spaceship_distance "*"
	    putStr "Enter new shot distance: "
	    input_text <- getLine
	    let shot_distance = (read input_text :: Int)
	    if shot_distance == spaceship_distance then
		do
		    redraw_positions spaceship_distance ">>Kaboom<<"
		    putStrLn "Spaceship destroyed.  You win."
	    else
		do
		    redraw_positions shot_distance "."
		    let (distance_moved,newGen)=randomR(5,15) gen::(Int,StdGen)
		    play_loop ( spaceship_distance - distance_moved ) newGen

--------------------------------------------------------------------------
--       Main								--
--------------------------------------------------------------------------
main = do
    gen <- getStdGen
    let ( spaceship_distance, newGen ) = randomR(10,75) gen :: (Int, StdGen)
    play_loop spaceship_distance newGen

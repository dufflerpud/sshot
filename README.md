# Documentation for Sshot:

In 1977, when I was in high school, I started programming in Digital
Equipment Corporation's Basic running on a PDP-8.  The OS, Basic, and any
programs I wrote were loaded on paper tapes through ASR-33 terminals.

My first real program was "sshot.bas", simple code that placed an asterisk
a random number of spaces over from the left side of the terminal, and
you guessed how man spaces it was.  If you got the number right, you won.
If you got the number wrong, it showed where your shot was, and then moved
the asterisk towards the left hand side.  This would repeat until either
you "hit the spaceship with your missile", or the spaceship hit you.

OK, not the most scintillating software ever written, but I was in
high school, nobody else around me had ANY programming experience, it
demonstrated several features of the language and I thought I was pretty
freaking cool.

As I write this, I've been a computer engineer for the last 45 years.
I've had computer courses that taught me new languages (Fortran, Pascal,
Algol, Simula, Cobol, LISP), and I've learned some on my own and used them
quite heavily (C, C++, Bourne Shell, Perl, Python, Javascript), I've
picked up some for small jobs but don't consider myself proficient in them
(TCL), and then I've learned some just to see what they are like (Ada,
Haskell, Ruby, Rust, Scala, Swift, X86 assembler).

There are others from way-back-when which I can't find any implementation
of the language to test with (e.g. APL, Snobol, Tops-10 and RT-11
assemblers) and so they are not included here.

In each case, my first program was "Hello World", and my second real
program was Sshot.

Please remember that the basic concepts of this program were dreamed up
by a high schooler during the time when MOST programming was done on
punch cards.

These implementations demonstrate:

	+ I/O to the terminal (stdin and stdout)
	+ Simple variable manipulation
	+ Integer manipulation
	+ If, If-else, For and While flow control
	+ Subroutines (that return no value)
	+ The use of the local random number generator

Notably missing:

	- Floating point numbers, arrays, records and complex types
	- Functions
	- Recursion (except for Haskell which forces you to)
	- Searching, hashing

And in most cases, there isn't a lot of error checking on user input.

Since I never considered this valuable code (just something to learn with),
once I had what I needed out of it, I generally discarded it.

45 years later, I am mentoring a kid who wants to learn about programming.
I gave him a step-by-step list of instructions on how to create Sshot in
Python, but this got me thinking of all the various times and ways I have
written this program.

So I sat down and over the course of the next few days, wrote all of these
implementations again.  The only code included that was not written in the
last few days is "sshot.pil", used as a test program for a simple class
compiler in my UNH days.

I've learned a few things:
	Your first language is your hardest.
	There comes a point where you have to discard "easy code",
	    for "maintainable code".  Comments are your friend
	    and certainly the friend of anybody who comes after you.
	Most everything you write over the span of your career will be
	    thrown away
	If you've got enough broad experience, it is possible to write
	    a simple program in most any modern computer language you
	    have never seen before with the help of Google.  Most of
	    the included implementations of sshot in unfamiliar languages
	    were written in under an hour.

I did NOT say they were written well.  --Chris Caldwell, 11/14/2022

<hr>

<table src="Makefile sshot.*"><tr><th align=left><a href='#dt_87O152XOV'>Makefile</a></th><td>Compile sshot versions where necessary</td></tr>
<tr><th align=left><a href='#dt_87O152XOW'>sshot.adb</a></th><td>Trivial program SShot written in ADA</td></tr>
<tr><th align=left><a href='#dt_87O152XOX'>sshot.alg</a></th><td>Trivial program SShot written in Algol-68</td></tr>
<tr><th align=left><a href='#dt_87O152XOY'>sshot.bas</a></th><td>Trivial program SShot written in YA-Basic</td></tr>
<tr><th align=left><a href='#dt_87O152XOZ'>sshot.cob</a></th><td>Trivial program SShot written in Cobol</td></tr>
<tr><th align=left><a href='#dt_87O152XOa'>sshot.cpp</a></th><td>Trivial program SShot written in C++</td></tr>
<tr><th align=left><a href='#dt_87O152XOb'>sshot.gcc</a></th><td>Trivial program SShot written in gcc</td></tr>
<tr><th align=left><a href='#dt_87O152XOc'>sshot.go</a></th><td>Trivial program SShot written in Go</td></tr>
<tr><th align=left><a href='#dt_87O152XOd'>sshot.hs</a></th><td>Trivial program SShot written in Haskell</td></tr>
<tr><th align=left><a href='#dt_87O152XOe'>sshot.java</a></th><td>Trivial program SShot written in java</td></tr>
<tr><th align=left><a href='#dt_87O152XOf'>sshot.js</a></th><td>Trivial program SShot written in Javascript</td></tr>
<tr><th align=left><a href='#dt_87O152XOg'>sshot.lsp</a></th><td>Trivial program SShot written in Lisp</td></tr>
<tr><th align=left><a href='#dt_87O152XOh'>sshot.pas</a></th><td>Trivial program SShot written in Pascal</td></tr>
<tr><th align=left><a href='#dt_87O152XOi'>sshot.pil</a></th><td>Trivial program SShot written in pil</td></tr>
<tr><th align=left><a href='#dt_87O152XOj'>sshot.pl</a></th><td>Trivial program SShot written in Perl</td></tr>
<tr><th align=left><a href='#dt_87O152XOk'>sshot.py</a></th><td>Trivial program SShot written in Python</td></tr>
<tr><th align=left><a href='#dt_87O152XOl'>sshot.rs</a></th><td>Trivial program SShot written in Rust</td></tr>
<tr><th align=left><a href='#dt_87O152XOm'>sshot.ruby</a></th><td>Trivial program SShot written in Ruby</td></tr>
<tr><th align=left><a href='#dt_87O152XOn'>sshot.s</a></th><td>Trivial program SShot written in GNU assembler</td></tr>
<tr><th align=left><a href='#dt_87O152XOo'>sshot.scala</a></th><td>Trivial program SShot written in Scala</td></tr>
<tr><th align=left><a href='#dt_87O152XOp'>sshot.sh</a></th><td>Trivial program SShot written in Bourne-Shell/BASH</td></tr>
<tr><th align=left><a href='#dt_87O152XOq'>sshot.swift</a></th><td>Trivial program SShot written in Swift</td></tr>
<tr><th align=left><a href='#dt_87O152XOr'>sshot.tcl</a></th><td>Trivial program SShot written in TCL</td></tr></table>

<hr>

<div id=docs>

## <a id='dt_87O152XOV'>Makefile</a>
Compile sshot versions where necessary
Also commands for bringing various compilers and interpreters
onto a Fedora Core machine.  That is not intended to be
comprehensive, only a place to start.

## <a id='dt_87O152XOW'>sshot.adb</a>
Trivial program SShot written in ADA

## <a id='dt_87O152XOX'>sshot.alg</a>
Trivial program SShot written in Algol-68

## <a id='dt_87O152XOY'>sshot.bas</a>
Trivial program SShot written in YA-Basic

## <a id='dt_87O152XOZ'>sshot.cob</a>
Trivial program SShot written in Cobol

## <a id='dt_87O152XOa'>sshot.cpp</a>
Trivial program SShot written in C++

## <a id='dt_87O152XOb'>sshot.gcc</a>
Trivial program SShot written in gcc

## <a id='dt_87O152XOc'>sshot.go</a>
Trivial program SShot written in Go

## <a id='dt_87O152XOd'>sshot.hs</a>
Trivial program SShot written in Haskell

## <a id='dt_87O152XOe'>sshot.java</a>
Trivial program SShot written in java

## <a id='dt_87O152XOf'>sshot.js</a>
Trivial program SShot written in Javascript

## <a id='dt_87O152XOg'>sshot.lsp</a>
Trivial program SShot written in Lisp

## <a id='dt_87O152XOh'>sshot.pas</a>
Trivial program SShot written in Pascal

## <a id='dt_87O152XOi'>sshot.pil</a>
Trivial program SShot written in pil

## <a id='dt_87O152XOj'>sshot.pl</a>
Trivial program SShot written in Perl

## <a id='dt_87O152XOk'>sshot.py</a>
Trivial program SShot written in Python

## <a id='dt_87O152XOl'>sshot.rs</a>
Trivial program SShot written in Rust

## <a id='dt_87O152XOm'>sshot.ruby</a>
Trivial program SShot written in Ruby

## <a id='dt_87O152XOn'>sshot.s</a>
Trivial program SShot written in GNU assembler

## <a id='dt_87O152XOo'>sshot.scala</a>
Trivial program SShot written in Scala

## <a id='dt_87O152XOp'>sshot.sh</a>
Trivial program SShot written in Bourne-Shell/BASH

## <a id='dt_87O152XOq'>sshot.swift</a>
Trivial program SShot written in Swift

## <a id='dt_87O152XOr'>sshot.tcl</a>
Trivial program SShot written in TCL</div>

<hr>

If you add a file with #doc#/#indx# lines, you should make sure it will be
found in the 'table src=' line above and then rerun github_readme in
this directory.

Similarly, if you remove files, re-run github_readme.










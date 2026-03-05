#!/bin/make test-sshot_s
#
#indx#	sshot.s - Trivial program SShot written in GNU assembler
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
#doc#	Trivial program SShot written in GNU assembler
########################################################################
#########################################################################
#       SShot implemented in GNU assembler by Chris Caldwell 11/03/2022	#
#	Tested with GNU assembler version 2.37 (x86_64-redhat-linux)	#
#########################################################################

	.global _start

#########################################################################
#	Macros to make this thing slightly easier to read.  Slightly.	#
#########################################################################

.set SYS_READ,		0	# Linux syscall SYS_ numbers
.set SYS_WRITE,		1
.set SYS_GETPID,	39
.set SYS_EXIT,		60
.set ASCII0,		48	# The ascii code for '0'
.set BUFSIZE,		200	# Size of input and output buffer

.macro MOVEMEM	mem1, mem2	# Macro from moving stuff from one place in
	push	%rax		# in memory to another
	mov	\mem1, %rax
	mov	%rax, \mem2
	pop	%rax
.endm

.macro	PUT_STRING_WITH	arg
	MOVEMEM	\arg, put_string_arg
	call	put_string
.endm

.macro	PUT_ANON_STRING arg
.section	.data
pas_string\@:	.string	"\arg"
.text
	PUT_STRING_WITH $pas_string\@
.endm

.macro	PUT_NUMBER_WITH	arg
	MOVEMEM	\arg, put_number_arg
	call	put_number
.endm

.macro	REDRAW_POSITIONS_ANON dist str
.section	.data
so_string\@:	.string "\str"
.text
	MOVEMEM	\dist, distance_arg
	MOVEMEM $so_string\@, text_arg
	call	redraw_positions
.endm

.macro PUSH_REGS		# For beginning of subroutines
	push	%rax
	push	%rbx
	push	%rcx
	push	%rdx
.endm

.macro POP_REGS			# For end of subroutines
	pop	%rdx
	pop	%rcx
	pop	%rbx
	pop	%rax
.endm

#########################################################################
#	Return a random number between the min and max args.		#
#	This is a really REALLY bad random number generator.		#
#########################################################################
.section	.bss
.lcomm	rand_min, 8
.lcomm	rand_max, 8
.lcomm	rand_return, 8
.lcomm	rand_seed, 8

.section	.text
rand_range:
	PUSH_REGS
	mov	rand_max,%rbx
	sub	rand_min,%rbx
	mov	rand_seed,%rax
	add	$1234567,%rax
	mov	%rax,rand_seed
	idiv	%rbx
	add	rand_min,%rdx
	mov	%rdx,rand_return
	POP_REGS
	ret

#########################################################################
#	Output a number.						#
#########################################################################
.section	.bss
.lcomm	put_number_arg, 8
.lcomm	put_number_string, 10

.section	.text
put_number:
	PUSH_REGS
	mov	put_number_arg,%rax
	mov	$put_number_string+8,%rbx
	movb	$0,(%rbx)
put_number_loop:
	xor	%rdx,%rdx
	mov	$10,%rcx
	div	%rcx
	add	$ASCII0,%rdx
	dec	%rbx
	movb	%dl,(%rbx)
	or	%rax,%rax
	jne	put_number_loop
	PUT_STRING_WITH %rbx
	POP_REGS
	ret

#########################################################################
#	io buffer read and write.					#
#########################################################################
.section	.bss
.lcomm	output_buffer,		BUFSIZE+8
.lcomm	output_buffer_count,	8
.lcomm	input_buffer,		BUFSIZE+1
.lcomm	input_buffer_count,	8

.section	.text
write_buf:
	PUSH_REGS
	mov	$1, %rdi		# Send this to standard out
	mov	output_buffer_count, %rdx	# Get number bytes to transmit
	mov	$output_buffer, %rsi	# Get address from buffer
	mov $SYS_WRITE, %rax; syscall	# Dump the buffer
	MOVEMEM	$0, output_buffer_count	# and restart it
	POP_REGS
	ret

read_buf:
	PUSH_REGS
	call	write_buf		# Make sure any prompt has been output
	mov	$0, %rdi		# IO channel to read from (stdin)
	mov	$input_buffer, %rsi	# Where to put the data
	mov	$BUFSIZE, %rdx		# Max data to read
	mov $SYS_READ, %rax; syscall	# Go get the data

	add	%rax, %rsi
	movb	$0, (%rsi)		# Make it null terminated
	MOVEMEM	%rax, input_buffer_count
	POP_REGS
	ret

#########################################################################
#	Put one byte in output buffer, but if that exceeds the size of	#
#	the buffer, write_buf it.					#
#########################################################################
.section	.bss
.lcomm	put_char_arg, 1
.section	.text
put_char:
	PUSH_REGS
	mov	output_buffer_count,%rax
	mov	put_char_arg,%bl
	movb	%bl, output_buffer(%rax)
	inc	%rax
	mov	%rax, output_buffer_count
	cmp	$BUFSIZE, %rax
	jl	put_char_end
	call	write_buf
put_char_end:
	POP_REGS
	ret

#########################################################################
#	Output a null terminated string.				#
#########################################################################
.section	.bss
.lcomm	put_string_arg, 8

.section	.text
put_string:
	PUSH_REGS
	mov	put_string_arg, %rsi	# Set %rsi to the address of the string
put_string_loop:
	movb	(%rsi), %bl		# Get a byte 
	or	%bl,%bl			# Check if null byte
	je	put_string_loop_exit	# if so, we're done
	inc	%rsi			# Increment byte pointer
	mov	%bl, put_char_arg	# set it up to call putchar
	call	put_char		# pop character in buffer
	jmp	put_string_loop		# and grab another
put_string_loop_exit:
	POP_REGS
	ret				# and return, chastened but no wiser

#########################################################################
#	Show a gun, space between and then another object.		#
#########################################################################
.section	.bss
.lcomm		distance_arg,	8
.lcomm		text_arg,	8

.section	.data
space:		.string	" "
.section	.text
redraw_positions:
	PUSH_REGS
	PUT_ANON_STRING "]"
	mov	distance_arg, %rbx		# Get counter
	MOVEMEM	$space, put_string_arg		# Setup to call put_string
redraw_positions_loop:
	or	%rbx, %rbx			# Exit loop if counter<=0
	jle	redraw_positions_loop_exit
	call	put_string			# Outputs space
	dec	%rbx				# Decrement counter
	jmp	redraw_positions_loop		# and loop
redraw_positions_loop_exit:

	PUT_STRING_WITH text_arg		# Output object/message
	PUT_ANON_STRING	"\n"
	POP_REGS
	ret

#########################################################################
#	Main								#
#########################################################################

.section	.bss
.lcomm		spaceship_distance,	8
.lcomm		shot_distance,		8

.section	.text
_start:
	mov $SYS_GETPID, %rax; syscall		# Use pid as seek (ick)
	MOVEMEM	%rax, rand_seed
	MOVEMEM	$10, rand_min
	MOVEMEM	$75, rand_max
	call	rand_range			# Random distance between 10&75
	MOVEMEM	rand_return, spaceship_distance

main_loop:
	REDRAW_POSITIONS_ANON spaceship_distance, "*"
	PUT_ANON_STRING "Enter new shot distance: "

	call	read_buf

	xor	%rax, %rax			# Zero out shot_distance
	mov	$input_buffer, %rbx		# Get pointer to first character
	mov	$10, %rdx

intloop:					# Create an integer based on
	xor	%rcx, %rcx			# the byte stream from SYS_READ
        movb	(%rbx), %cl
	inc	%rbx
	sub	$ASCII0, %rcx
	cmp	$0, %rcx
	jl	intloop_done
	cmp	$9, %rcx
	jg	intloop_done
	mov	$10, %rdx
	mul	%rdx
	add	%rcx, %rax
	call	write_buf
	jmp	intloop
intloop_done:

	MOVEMEM	%rax, shot_distance	# Save result away
	cmp	$1, %rax		# Error check range of shot distance
	jl	input_error
	cmp	$75, %rax
	jle	input_ok
input_error:
	PUT_ANON_STRING "You must enter an int between 1 and 75.\n"
	jmp	main_loop

input_ok:				# Check if he hit the spaceship
	cmp	%rax, spaceship_distance
	jne	he_missed

he_wins:				# He did, show where and win.
	REDRAW_POSITIONS_ANON spaceship_distance, ">>Kaboom<<\nSpaceship destroyed.  You win.\n"
	jmp	end_prog

he_missed:				# He didn't, show where missile went
	REDRAW_POSITIONS_ANON shot_distance, "."

	mov	spaceship_distance, %rbx	# Move incoming spaceship
	MOVEMEM	$5, rand_min
	MOVEMEM	$15, rand_max
	call	rand_range
	sub	rand_return, %rbx
	MOVEMEM	%rbx, spaceship_distance
	cmp	$1, %rbx
	jg	main_loop			# If <= 1, collision!

he_loses:
	REDRAW_POSITIONS_ANON $0, "<<Kaboom>>\nSpaceship has collided with you.  You lose.\n"

end_prog:
	call	write_buf
	mov	$0,%rdi
	mov	$SYS_EXIT, %rax; syscall

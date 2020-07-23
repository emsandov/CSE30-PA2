/*
 * Filename: allcaps.s
 * Author: Emi Sandoval
 * UserId: cs30s120br
 * Date: 07/16/2020
 * Sources of help: Autograder tutor: Kim, Piazza posts: @261
 */

	@ hardware
		.arch	armv6
		.cpu	cortex-a53
		.syntax	unified
	@ externs
		.extern putchar
		.global main
	@ define constants
		.equ FP_OFFSET,	12	@ fp offset in stack frame
		.equ LC_A,	0x61	@ lower case a
		.equ LC_Z,	0x7a	@ lower case z
		.equ NULL,	0x0	@ '\0'
		.equ EXIT_SUCCESS, 0	@ success return from main
		.equ SUBVL,	0x20	@ value to subtract by to get caps
		.section .rodata
	@ data
		.data
	mesg: 	.asciz  "Hello World!\n"
	@text
		.text
		.align	2
	main: 	
		push	{r4, r5, fp, lr}
		add	fp, sp, FP_OFFSET

		mov 	r1, 0		@ initialize counter
		mov	r0, 0		@ clear r0
		ldr	r4, =mesg
		ldrb	r0, [r4]	@ Get next byte/char in the string
		cmp	r0, NULL	@ If at end of string we are done
		beq	done
	loop:
		cmp	r0, LC_A	@ compare to lower case a
		blt	next		@ if below lower-case a, skip char
		cmp	r0, LC_Z	@ compare to lower-case z
		bgt	next		@ if above lower-case z, skip char
		sub	r0, r0, SUBVL	@ subtract to get the capital letter
	next:
		bl	putchar		@ print to putchar
		add	r4, r4, 1	@ increment char index
		ldrb	r0, [r4]	@ Get next character in the string
		cmp	r0, NULL	@ If at end of string we are done
		bne	loop		@ get next character
	done:	
		mov	r0, EXIT_SUCCESS
		sub	sp, fp, FP_OFFSET
		pop 	{r4, r5, fp, lr}
		bx	lr
	.end
}

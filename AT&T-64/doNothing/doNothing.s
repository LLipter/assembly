		.text
		.globl	main
		.type	main, @function
main:	pushq	%rbp				# save caller’s frame pointer 
		movq	%rsp, %rbp			# establish our frame pointer
		movl	$0, %eax			# return 0 to caller
		movq	%rbp, %rsp			# restore stack pointer
		popq	%rbp				# restore caller’s frame pointer
		ret

		.section	.rodata
msg:	.string	"hello world\n"
		.text
		.globl	main
		.type	main, @function
main:	
		pushq	%rbp
		movq	%rsp, %rbp
		
		movq	$1, %rdi		# 1st argument, std_out number
		movq	$msg, %rsi		# 2nd argument, address of string
		movq	$13, %rdx		# 3rd argument, length of string
		call	write
		
		movq	%rbp, %rsp
		popq	%rbp
		ret
		

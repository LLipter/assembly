# Compilation Steps
1. Preprocessing. This resolves compiler directives such as #include (file inclusion), #define (macro definition), and #if (conditional compilation) by invoking the program cpp. Compilation can be stopped at the end of the preprocessing phase with the `-E` option, which writes the resulting C source code to standard out.
2. Compilation itself. The source code that results from preprocessing is translated into assembly language. Compilation can be stopped at the end of the compilation phase with the `-S` option, which writes the assembly language source code to filename.s.
3. Assembly. The assembly language source code that results from compilation is translated into machine code by invoking the as program. Compilation can be stopped at the end of the assembly phase with the `-c` option, which writes the machine code to filename.o.
4. Linking. The machine code that results from assembly is linked with other machine code from standard C libraries and other machine code modules, and addresses are resolved. This is accomplished by invoking the ld program. The default is to write the executable file, a.out. A different executable file name can be specified with the `-o` option.

# Assembly Syntax

`label:   operation   operand(s)   #comment`

 - The label ﬁeld allows us to give a symbolic name to any line in the program. Since each line corresponds to a memory location in the program, other parts of the program can then refer to the memory location by name.
 - The operation ﬁeld provides the basic purpose of the line. There are two types of operations: 

 	* assembly language mnemonic — The assembler translates these into actual machine instructions, which are copied into memory when the program is to be executed. Each machine instruction will occupy from one to five bytes of memory.
 	* assembler directive(pseudo op) — Each of these operations begins with the period (“.”) character. They are used to direct the way in which the assembler translates the file. They do not translate directly into machine instructions, although some do cause memory to be allocated.
 - The operand ﬁeld specifies the arguments to be used by the operation. The arguments are specified in several different ways:
 - The comment ﬁeld is just like a comment line, except it takes up only the remainder of the line. Since assembly language is not as easy to read as higher-level languages, good programmers will place a comment on almost every line.


Compiler-generated labels begin with the `.` character, and many system related names begin with the `_` character. It is a good idea to avoid beginning your own labels with the `.` or the `_` character so that you do not inadvertently create one that is already in use by the system.

# Segment

GNU/Linux divides memory into different segments for specific purposes when a program is loaded from the disk. The four general categories are:

 - text (also called code) is where program instructions and constant data are stored. It is read-only memory. The operating system prevents a program from changing anything stored in the text segment.
 - data is where global variables and static local variables are stored. It is read-write memory and remains in place for the duration of the program.
 - stack is where automatic local variables and the data that links functions are stored. It is read-write memory that is allocated and deallocated dynamically as the program executes.
 - heap is the pool of memory available when a C program calls the malloc function (or C++ calls new). It is read-write memory that is allocated and deallocated by the program.

# Assembler
 
An assembler must perform the following tasks:

 - Translate assembly language mnemonics into machine language.
 - Translate symbolic names for addresses into numeric addresses.

The simplest solution is to use a two-pass assembler:

 1. The first pass builds a symbol table, which provides an address for each memory label.
 2. The second pass performs the actual translation into machine language, consulting the symbol table for numeric values of the symbols.

However, some symbolic names are references to a memory label outside the file being assembled. Thus, the assembler has no way to determine the address of write for the symbol table during the first pass. The only thing the assembler can do during the second pass is to leave enough memory space for the address of write when it assembles this instruction. The actual address will have to be filled in later in order to create the entire program. Filling in these references to external memory locations is the job of the linker program.

# Linker

The algorithm for linking functions together is very similar to that of the assembler. The same forward reference problem exists. Again, the simplest solution is to use a two-pass linker program.


# Call functions

## Passing Arguments

With x86-64, up to six integral arguments can be passed via registers. The registers are used in a specific order, with the name used for a register depending on the size of data type being passed.

<center>
<table>
	<tr>
		<td rowspan=2>Operand size (bits)</td>
		<td colspan=6 align='center'>Argument number</td>
	</tr>
	<tr align='center'>
		<td>1</td>
		<td>2</td>
		<td>3</td>
		<td>4</td>
		<td>5</td>
		<td>6</td>
	</tr>
	<tr>
		<td align='center'>64</td>
		<td>%rdi</td>
		<td>%rsi</td>
		<td>%rdx</td>
		<td>%rcx</td>
		<td>%r8</td>
		<td>%r9</td>
	</tr>
	<tr>
		<td align='center'>32</td>
		<td>%edi</td>
		<td>%esi</td>
		<td>%edx</td>
		<td>%ecx</td>
		<td>%r8d</td>
		<td>%r9d</td>
	</tr>
	<tr>
		<td align='center'>16</td>
		<td>%di</td>
		<td>%si</td>
		<td>%dx</td>
		<td>%cx</td>
		<td>%r8w</td>
		<td>%r9w</td>
	</tr>
	<tr>
		<td align='center'>8</td>
		<td>%dil</td>
		<td>%sil</td>
		<td>%dl</td>
		<td>%cl</td>
		<td>%r8b</td>
		<td>%r9b</td>
	</tr>
</table>
</center>

With a function has more than six integral arguments, the others ones are passed on the stack. Notice that arguments have to be pushed into the stack in reverse order, so that the 7th argument is on the top of the stack.


# How to Call functions

The assembly language instruction used to call a function is

`call	functionName`

where `functionName` is the name of the function being called. The call instruction does two things:

 1. The address in the rip register is pushed onto the call stack. Recall that the rip register is incremented immediately after the instruction is fetched. Thus, when the call instruction is executed, the value that gets pushed onto the stack is the address of the instruction immediately following the call instruction. That is, the return address gets pushed onto the stack in this first step.
 2. The address that functionName resolves to is placed in the rip register. This is the address of the function that is being called, so the next instruction to be fetched is the first instruction in the called function.

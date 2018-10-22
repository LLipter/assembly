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

 
 
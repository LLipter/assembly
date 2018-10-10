DATA    SEGMENT
QUEEN   DB  8  DUP(?)               ; location of queens
ANS     DB  0                       ; number of solutions
DATA    ENDS

CODE	SEGMENT
	    ASSUME  CS:CODE,ES:DATA,DS:DATA
MAIN	PROC	FAR
START:	PUSH	DS
	    SUB 	AX,AX
	    PUSH	AX

        MOV     AX,DATA             ; set up for data segment
        MOV     DS,AX
        MOV     SI,OFFSET QUEEN


        PUSH


        RET
MAIN	ENDP

PRINTER PROC    NEAR
        MOV     DL,0AH              ; print \n
        MOV     AH,2
        INT     21H


        RET
PRINTER ENDP

CODE	ENDS
	END MAIN

DATA    SEGMENT
QUEEN   DB  9  DUP(?)                   ; location of queens, declare 1 more byte so that index starts with 1
ANS     DB  0                           ; number of solutions
CUR     DB  1                           ; index of current positioning queen
ISVILID BD  0                           ; whether current queen is valid
DATA    ENDS

CODE	SEGMENT
        ASSUME  CS:CODE,ES:DATA,DS:DATA
MAIN	PROC	FAR
START:	PUSH	DS
        SUB 	AX,AX
        PUSH	AX

        MOV     AX,DATA                 ; set up for data segment
        MOV     DS,AX
        MOV     SI,OFFSET QUEEN
  


STOP:   RET
MAIN	ENDP

CHECK   PROC    NEAR
        MOV     CX,CUR
        DEC     CX
        CMP     CX,0                    ; first queen is always valid
        JE      VALID
LOOP1:  MOV     AX,QUEEN[CX]
        MOV     BX,QUEEN[CUR]
        SUB     AX,BX                   ; duplicate location is invalid
        JE      INVALID
        JNC     CROSS                   ; AX is greater than BX, difference is positive, jump to CROSS
        NOT     AX                      ; otherwise, difference is negative
        INC     AX                      ; AX = -AX, now the difference is positive
CROSS:  MOV     BX,CUR
        SUB     BX,CX                   ; BX is the difference of their index
        CMP     AX,BX
        JE      INVALID
        LOOP    LOOP1

VALID:  MOV     ISVALID,1
        RET
INVALID:MOV     ISVALID,0
        RET
CHECK   ENDP


PRINTER PROC    NEAR
        MOV     DL,0AH                  ; print \n
        MOV     AH,2
        INT     21H


        RET
PRINTER ENDP

CODE	ENDS
	END MAIN

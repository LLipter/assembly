DATA    SEGMENT
QUEEN   DB  9  DUP(?)                   ; location of queens, declare 1 more byte so that index starts with 1
ANS     DB  0                           ; number of solutions
CUR     DW  0                           ; index of current positioning queen
ISVILID DB  0                           ; whether current queen is valid
QNO     DW  8                           ; number of queens
DATA    ENDS

CODE	SEGMENT
        ASSUME  CS:CODE,ES:DATA,DS:DATA
MAIN	PROC	FAR
START:	PUSH	DS
        SUB 	AX,AX
        PUSH	AX

        MOV     AX,DATA                 ; set up for data segment
        MOV     DS,AX

        CALL    DFS

        MOV     AX,0
        MOV     AL,ANS                  ; AX = ANS
        MOV     BL,10
        DIV     BL                      ; AH = AX % 10, AL = AX / 10
        XCHG    AH,AL                   ; AL = AX % 10, AH = AX / 10
        OR      AX,3030H                ; transform to ASCII representation
        MOV     CX,AX

        MOV     DL,CH                   ; print first number
        MOV     AH,2
        INT     21H
        MOV     DL,CL                   ; print second number
        MOV     AH,2
        INT     21H
        MOV     DL,0DH                  ; print \r
        MOV     AH,2
        INT     21H
        MOV     DL,0AH                  ; print \n
        MOV     AH,2
        INT     21H 

        RET
MAIN	ENDP

CHECK   PROC    NEAR
        MOV     CX,CUR
        DEC     CX
        CMP     CX,0                    ; first queen is always valid
        JE      VALID
LOOP1:  MOV     AL,QUEEN[CX]
        MOV     BL,QUEEN[CUR]
        SUB     AL,BL                   ; duplicate location is invalid
        JE      INVALID
        JNC     CROSS                   ; AX is greater than BX, difference is positive, jump to check cross lines
        NOT     AL                      ; otherwise, difference is negative
        INC     AL                      ; AX = -AX, now the difference is positive
CROSS:  MOV     BX,CUR
        SUB     BX,CX                   ; BX is the difference of their index
        CMP     AL,BL
        JE      INVALID
        LOOP    LOOP1
VALID:  MOV     ISVALID,1
        RET
INVALID:MOV     ISVALID,0
        RET
CHECK   ENDP


DFS     PROC    NEAR
        INC     CUR
        MOV     CX,QNO
        CMP     CUR,CX                  ; if all queens have been placed, solution found
        JA      FOUND

LOOP3:  MOV     QUEEN[CUR],CL
        PUSH    CX                      ; protect CX
        CALL    CHECK
        POP     CX                      ; revover CX
        CMP     ISVALID,1               ; if current queen is valid, then go deeper
        JE      DEEPER                  
        JMP     CONT                    ; otherwise, place current queen to another position
DEEPER: PUSH    CX                      ; protect CX
        CALL    DFS
        POP     CX                      ; revover CX
CONT:   LOOP    LOOP3
        JMP     STOP

FOUND:  INC     ANS
        CALL    PRINTER
STOP:   DEC     CUR
        RET
DFS     ENDP


PRINTER PROC    NEAR
        MOV     CX,1
LOOP2:  MOV     DL,QUEEN[CX]
        OR      DL,3OH                  ; transform to ASCII format
        MOV     AH,2
        INT     21H
        MOV     DL,20H                  ; print space
        MOV     AH,2
        INT     21H
        INC     CX
        CMP     CX,QNO                  ; if CX <= QNO, keep printing
        JBE     LOOP2     

        MOV     DL,0DH                  ; print \r
        MOV     AH,2
        INT     21H
        MOV     DL,0AH                  ; print \n
        MOV     AH,2
        INT     21H 
        RET
PRINTER ENDP

CODE	ENDS
	END MAIN

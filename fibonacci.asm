DATA    SEGMENT
FL      DW  30  DUP(0)  ; lower part of result
FH      DW  30  DUP(0)  ; high part of result
TMP     DW  ?
TMP1    DW  ?
TMP2    DW  ?
DATA    ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,ES:DATA,DS:DATA
MAIN	PROC	FAR
START:	PUSH	DS
	SUB 	AX,AX
	PUSH	AX

        MOV     AX,DATA             ; set up for data segment
        MOV     DS,AX
        MOV     SI,OFFSET FL
        MOV     DI,OFFSET FH

        MOV     WORD PTR [SI],1     ; the first number of fibonacci sequence
        MOV     WORD PTR [SI+2],1   ; the second number of fibonacci sequence
        ADD     SI,4
        ADD     DI,4

        MOV     CX,28               ; loop 28 times
AGAIN:  MOV     AX,[SI-2]
        MOV     BX,[SI-4]
        ADD     AX,BX               ; add lower part
        MOV     [SI],AX

        MOV     AX,[DI-2]
        MOV     BX,[DI-4]
        ADC     AX,BX               ; add higher part
        MOV     [DI],AX
        
        ADD     SI,2
        ADD     DI,2
        LOOP    AGAIN

        MOV     CX,30
        MOV     SI,OFFSET FL
        MOV     DI,OFFSET FH
PRINT:  MOV     AX,[DI]
        MOV     BX,[SI]
        MOV     TMP1,AX
        MOV     TMP2,BX
        CALL    PRINTER
        ADD     SI,2
        ADD     DI,2
        LOOP    PRINT 

        RET
MAIN	ENDP

PRINTER PROC    NEAR
        MOV     TMP,CX              ; protect original CX

        MOV     CX,16               ; loop 16 times
        MOV     BX,TMP1
LOOP1:  SHL     BX,1
        JC      ONE1
        MOV     DL,30H
        JMP     PT1  
ONE1:   MOV     DL,31H  
PT1:    MOV     AH,2
        INT     21H                 ; print binary number
        LOOP    LOOP1

        MOV     DL,20H              ; print space
        MOV     AH,2
        INT     21H

        MOV     CX,16               ; loop 16 times
        MOV     BX,TMP2
LOOP2:  SHL     BX,1
        JC      ONE2
        MOV     DL,30H 
        JMP     PT2 
ONE2:   MOV     DL,31H  
PT2:    MOV     AH,2
        INT     21H                 ; print binary number
        LOOP    LOOP2

        MOV     DL,0DH              ; print \r
        MOV     AH,2
        INT     21H

        MOV     DL,0AH              ; print \n
        MOV     AH,2
        INT     21H

        MOV     CX,TMP              ; recover CX

        RET
PRINTER ENDP

CODE	ENDS
	END MAIN

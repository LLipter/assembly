DATA    SEGMENT
FL      DW      30  DUP(0)              ; lower part of result
FH      DW      30  DUP(0)              ; high part of result
TMP     DW      ?               
DATA    ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,ES:DATA,DS:DATA
MAIN	PROC	FAR
START:	PUSH	DS
	SUB 	AX,AX
	PUSH	AX

        MOV     AX,DATA                 ; set up for data segment
        MOV     DS,AX
        MOV     SI,OFFSET FL
        MOV     DI,OFFSET FH

        MOV     WORD PTR [SI],1         ; the first number of fibonacci sequence
        MOV     WORD PTR [SI+2],1       ; the second number of fibonacci sequence
        ADD     SI,4
        ADD     DI,4

        MOV     CX,28                   ; loop 28 times
AGAIN:  MOV     AX,[SI-2]
        MOV     BX,[SI-4]
        ADD     AX,BX                   ; add lower part
        MOV     [SI],AX

        MOV     AX,[DI-2]
        MOV     BX,[DI-4]
        ADC     AX,BX                   ; add higher part
        MOV     [DI],AX
        
        ADD     SI,2
        ADD     DI,2
        LOOP    AGAIN

        MOV     CX,30
        MOV     SI,OFFSET FL
        MOV     DI,OFFSET FH
PRINT:  MOV     DX,[DI]
        MOV     AX,[SI]
        PUSH    CX                      ; protect CX
        CALL    PRINTER
        POP     CX                      ; recover CX
        ADD     SI,2
        ADD     DI,2
        LOOP    PRINT 

        RET
MAIN	ENDP

PRINTER PROC    NEAR
        MOV     CX,10000
        DIV     CX
        MOV     TMP,AX                  ; protect higher part of number

        MOV     CX,4                    ; loop 4 times
        MOV     AX,DX
LOOP1:  MOV     DX,0
        MOV     BX,10
        DIV     BX                      ; AX = AX / 10, DX = AX % 10
        PUSH    DX                      ; store remainder
        LOOP    LOOP1        

        MOV     CX,2                    ; loop 2 times
        MOV     AX,TMP                  ; recover higher part of number
LOOP2:  MOV     DX,0
        MOV     BX,10
        DIV     BX                      ; AX = AX / 10, DX = AX % 10
        PUSH    DX                      ; store remainder
        LOOP    LOOP2   



        MOV     CX,6                    ; loop 6 times to print 6 dights
LOOP3:  POP     DX  
        OR      DL,30H                  ; transform to ASCII
        MOV     AH,2
        INT     21H
        LOOP    LOOP3

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

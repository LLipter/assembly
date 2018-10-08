DATA    SEGMENT
PRIME   DB  100 DUP(?)  ; result
DATA    ENDS


CODE	SEGMENT
		ASSUME  CS:CODE,DS:DATA,
                ES:DATA
MAIN	PROC	FAR
START:	PUSH	DS
		SUB		AX,AX
		PUSH	AX

        MOV     AX,DATA ; set up for data segment
        MOV     DS,AX
        MOV     SI,OFFSET PRIME
        MOV     DI,OFFSET PRIME

        MOV     CH,1    ; outer counter, range from 2 to 100
OUTER:  INC     CH      
        CMP     CH,100
        JA      PRINT   ; if outer counter is greater than 100, jump to print result
        MOV     CL,1    ; inner counter, range from 2 to CH/2
INNER:  INC     CL
        CMP     CL,CH/2 ; if inner counter is greater than half of outer counter, this number is prime number
        JA      STORE   ; jump to store it

        XOR     AX,AX   ; AX = 0
        MOV     AL,CH   ; AX = AL = CH, AH = 0
        DIV     CL      ; AH = CH % CL

        CMP     AH,0    ; if remainder is 0, this number is not prime number
        JE      OUTER   ; jump to outer loop

        JMP     INNER
STORE:  MOV     [SI],CH
        INC     SI
        JMP     OUTER   ; keep looping

PRINT:  CMP     DI,SI   ; if DI is equal to SI, all numbers printed
        JE      STOP    ; jump to end

        SUB     AX,AX   ; AX = 0
        MOV     AL,[DI]
        CALL    PRINTER

        INC     DI
        JMP     PRINT   ; keep printing

STOP:   RET
MAIN	ENDP

PRINTER PROC    NEAR
        MOV     BL,10
        DIV     BL          ; AH = AX % 10, AL = AX / 10
        XCHG    AH,AL       ; AL = AX % 10, AH = AX / 10
        OR      AX,3030H    ; transform to ASCII representation
        MOV     CX,AX

        MOV     DL,CH       ; print first number
        MOV     AH,2
        INT     21
        MOV     DL,CL       ; print second number
        MOV     AH,2
        INT     21
        MOV     DL,0DH      ; print \r
        MOV     AH,2
        INT     21
        MOV     DL,0CH      ; print \n
        MOV     AH,2
        INT     21
        RET
PRINTER ENDP

CODE	ENDS
		END MAIN

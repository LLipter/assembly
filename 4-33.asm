PROG1   SEGMENT
        ASSUME  CS:PROG1
START:  MOV     DL,1
        MOV     AH,2
        INT     21H
        MOV     AX,4C00H
        INT     21H
PROG1   ENDS
END     START
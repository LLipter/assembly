BEGIN:
        MOV AL,0        ; lower limit
UP:
        OUT     220H
        CALL    DELAY
        INC     AL
        CMP     AL,0H   ; reach upper limit?
                        ; 0H is the result of "255+1", integer overflow
        JNZ     UP      ; doesn't reach upper limit, keep looping
        DEC     AL      ; reach upper limit, start decreasing
DOWN:
        OUT     220H
        CALL    DELAY
        DEC     AL
        CMP     AL,0FFH ; reach lower limit? 
                        ; 0FFH is the result of "0-1", integer underflow
        JNZ     DOWN    ; doesn't reach lower limit, keep looping
        JMP     BEGIN   ; reach lower limit, start increasing
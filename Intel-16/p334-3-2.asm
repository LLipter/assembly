; lower limit = 1.2V / (5V/256) = 61 = 3DH
; upper limit = 4V / (5V/256) = 205 = 0CDH

BEGIN:
        MOV AL,3DH          ; lower limit
UP:
        OUT     220H
        CALL    DELAY
        INC     AL
        CMP     AL,0CEH     ; reach upper limit?
        JNZ     UP          ; doesn't reach upper limit, keep looping
        CALL    DELAY_20MS
        DEC     AL          ; reach upper limit, start decreasing
DOWN:
        OUT     220H
        CALL    DELAY
        DEC     AL
        CMP     AL,3CH      ; reach lower limit? 
        JNZ     DOWN        ; doesn't reach lower limit, keep looping
        CALL    DELAY_20MS
        JMP     BEGIN       ; reach lower limit, start increasing
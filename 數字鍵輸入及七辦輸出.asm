	MOV R0,00H
start:
	
	MOV R0, #0		; clear R0 - the first key is key0

	; scan row0
	SETB P0.1
	SETB P0.2
	SETB P0.3		; set row3
	CLR P0.0		; clear row0
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
				; | (because the pressed key was found and its number is in  R0)

	; scan row1
	SETB P0.0		; set row0
	CLR P0.1		; clear row1
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
				; | (because the pressed key was found and its number is in  R0)

	; scan row2
	SETB P0.1		; set row1
	CLR P0.2		; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
				; | (because the pressed key was found and its number is in  R0)

	; scan row3
	SETB P0.2		; set row2
	CLR P0.3		; clear row3
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
				; | (because the pressed key was found and its number is in  R0)


	JMP start		; | go back to scan row 0
				; | (this is why row3 is set at the start of the program
				; | - when the program jumps back to start, row3 has just been scanned)

; column-scan subroutine
colScan:
	JNB P0.4, gotKey	; if col0 is cleared - key found
	INC R0			; otherwise move to next key
	JNB P0.5, gotKey	; if col1 is cleared - key found
	INC R0			; otherwise move to next key
	JNB P0.6, gotKey	; if col2 is cleared - key found
	INC R0			; otherwise move to next key
	RET			; return from subroutine - key not found
gotKey:
	SETB F0			; key found - set F0
	RET			; and return from subroutine
finish:
	INC R0
	MOV 30H, R0			; program execution arrives here when key is found - do nothing
	CLR F0
	SETB P3.3		; |
	SETB P3.4		; | enable display 3
	DJNZ 30H,display0
	MOV P1, #11110110B	;#
	JMP start
display0:
    DJNZ 30H,displayH
	MOV P1, #11000000B	;0
	JMP start
displayH:
    DJNZ 30H,display9
	MOV P1, #10001001B	;*
	JMP start
display9:
    DJNZ 30H,display8
	MOV P1, #10011000B	;9
	JMP start
display8:
    DJNZ 30H,display7
	MOV P1, #10000000B	;8
	JMP start
display7:
    DJNZ 30H,display6
	MOV P1, #11011000B	;7
	JMP start
display6:
    DJNZ 30H,display5
	MOV P1, #10000010B	;6
	JMP start
display5:
    DJNZ 30H,display4
	MOV P1, #10010010B	;5
    JMP start
display4:
    DJNZ 30H,display3
	MOV P1, #10011001B	;4
	JMP start
display3:
    DJNZ 30H,display2
	MOV P1, #10110000B	;3
	JMP start
display2:
    DJNZ 30H,display1
	MOV P1, #10100100B	;2
	JMP start
display1:
	MOV P1, #11111001B	; put pattern for 1 on display
	JMP start
PUSH AL		;Push default value of Al onto the stack
MOV BL,40	;Push 40 into BL (Strating element of the array)
PUSH BL		;Push starting address of the array onto the stack
PUSH CL		;Push default value of Cl onto the stack
loop1:
	IN 00		;Input stored in AL
	SUB AL,30	;Convert AL from ascii by subtracting 48 (30 in hex)
	MOV CL,[BL]	;Move value in array to CL
	CMP CL,FF	;Check if element is the last element
	JZ end2		;Jump to end of function if its the last element
	MOV [BL],AL	;Put user input into the array
	INC BL		;Incrment BL to go to next element
	CMP AL,DD	;Check if user entered enter
	JZ end1		;Jump to end 1 to overwrite enter
	JMP loop1	;Start loop1 again if user input wasn't enter
end1:
	SUB BL,1	;Go back one element in the array to overwrite enter as FF
	MOV CL,FF	;Move FF into CL
	MOV[BL],CL	;Overwrite enter in array with FF
end2:
	CALL 50		;Call function
	HALT

ORG 40			;Create array and initialize all elements with 0 and a max of 8 elements
DB 00
DB 00
DB 00
DB 00
DB 00
DB 00
DB 00
DB 00
DB FF			;Set FF as the end of the array

ORG 50			;Create a function to square elements and add them together
POP DL			;POP function return value from the stack
POP AL			;Reset AL for use in the function by poping default value from the stack
POP BL			;POP starting element of array into BL
POP CL			;Reset CL for use in this function by poping default value from the stack
PUSH DL			;Push the function return value back onto the stack so that it can return to the main program
loop2:
	MOV CL,[BL]	;Move elemnt of array into CL
	MOV DL,[BL]	;Move element of array into DL
	CMP DL,FF	;Check if element is last element so that it isn't added to AL
	JZ end		;Jump to end of function if its the last element
	MUL CL,DL	;Square the element
	ADD AL,CL	;Add the squared number to AL
	INC BL		;Increment BL to go to next element
	JMP loop2	;Restart loop2
end:
	POP DL 		;POP function return address into DL
	PUSH AL		;PUSH AL (The total square feet) onto the stack
	PUSH DL		;POP function return value from the stack
	RET		;Return to main program
END

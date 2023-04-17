; ******************************** SOL Q1 ****************************************************

	.model small
	.stack 100h

	; .data

	; .code
	; ; connecting the data and code segment
	; mov ax,@data
	; mov ds,ax

	; mov dl,1 ; for starting from 1
	; add dl,48 ; adding 0 into it

	; mov cx,5

	; l1: ; add 2 and you would get even
	; mov ah,02 ; printing scenes
	; int 21h

	; add dl,2 
	; loop l1

	; mov dl,10 ; printing scenes
	; mov ah, 2
	; int 21h
	; mov dl,13
	; mov ah, 2
	; int 21h

	; mov dl,2
	; add dl,48

	; mov cx,5

	; l2: ; add 2 and you would get odd

	; mov ah,02
	; int 21h

	; add dl,2
	; loop l2

	; mov ah,4ch
	; int 21h
	; end
; ******************************** Ending SOL Q1 ****************************************************


; ******************************** Starting SOL Q1 ****************************************************
 

; .data
; sum dw 0 ; initialize variable to store the sum

; .code
; main proc

;     mov ax, @data ; initialize data segment
;     mov ds, ax

;     mov cx, 3 ; initialize loop counter to 3

;     mov bx, 1 ; initialize variable to store current number to 1

; loop_start:
;     add sum, bx ; add current number to sum
;     inc bx ; increment current number by 1
;     loop loop_start ; decrement loop counter and loop until it reaches 0

;     ; print the sum
;     mov ax, sum ; move sum to ax register
;     add ax, 30h ; convert sum to ASCII value
;     mov ah, 02h ; set AH to 02h for printing character
;     mov dl, al ; move ASCII value of sum to DL
;     int 21h

;     mov ah, 4ch ; exit program
;     int 21h

; main endp
; end main

; ******************************** Ending SOL Q2 ****************************************************
 

; ******************************** SOL Q3 ****************************************************
 
;  .data

; .code
; main proc

;     mov ax, @data ; initialize data segment
;     mov ds, ax

;     ; print capital letters from A to Z
;     mov dl, 'A' ; set starting character
; loop_capitals:
;     mov ah, 02h ; set AH to 02h for printing character
;     int 21h ; output current character
;     inc dl ; increment current character
;     cmp dl, 'Z' ; compare current character to 'Z'
;     jle loop_capitals ; loop until current character is greater than 'Z'

;     ; print newline character
;     mov dl, 10 ; ASCII value of newline character
;     mov ah, 02h ; set AH to 02h for printing character
;     int 21h ; output newline character

;     ; print small letters from a to z
;     mov dl, 'a' ; set starting character
; loop_smalls:
;     mov ah, 02h ; set AH to 02h for printing character
;     int 21h ; output current character
;     inc dl ; increment current character
;     cmp dl, 'z' ; compare current character to 'z'
;     jle loop_smalls ; loop until current character is greater than 'z'

;     ; print newline character
;     mov dl, 10 ; ASCII value of newline character
;     mov ah, 02h ; set AH to 02h for printing character
;     int 21h ; output newline character

;     mov ah, 4ch ; exit program
;     int 21h

; main endp
; end main

; ******************************** Ending SOL Q3 ****************************************************
 

; ******************************** SOL Q4 ****************************************************
; .data
;     n db 10 ; number of natural numbers to print
;     count db 1 ; counter for loop

; .code
; main proc

;     mov ax, @data ; initialize data segment
;     mov ds, ax

;     ; print the first 10 natural numbers using a loop
;     mov cx, 10 ; set CX to the value of n

; loop_numbers:

;     mov ah, 02h ; set AH to 02h for printing character
;     mov dl, count ; move the value of count to DL for printing
;     add dl, 48 ; convert DL to its ASCII equivalent
;     int 21h ; output the current number
;     inc count ; increment the counter
;     loop loop_numbers ; repeat the loop until CX is zero

;     mov ah, 4ch ; exit program
;     int 21h

; main endp
; end main
; ******************************** Ending SOL Q4 ****************************************************	
	.data
	count dw ?
	var1 dw ?
	
	
	.code
	main proc
	mov ax,@data
	mov ds,ax
	mov var1 , 48
	mov bx, 1
	mov cx, 5
	
	L1:
	mov count,cx
	mov cx, bx

	L2:
	Mov dl, var1
	mov ah,2
	int 21h
	
	loop L2
	mov dl,10
	mov ah, 2
	int 21h
	inc var1
	mov dl,13
	mov ah, 2
	int 21h

	inc bx

	mov cx,count ; restoring value
	loop L1

	mov ah,4ch
	int 21h

	main endp
	end main


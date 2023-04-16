; Press (control + /) in vscode to uncomment codes.
; LAB 03

.model small
.stack 100h


; **************************************** Start of Q1 ****************************************************

; Write Assembly program to add two numbers using variables.

; .data
; var1 db 5
; var2 db 2

; .code
; main proc 
; mov ax , @data
; mov ds , ax

; mov al, var1

; add al , var2

; mov dl,al
; add dl , 30h ; convert to ascii

; mov ah,02h
; int 21h

; mov ah ,4ch
; int 21h
; main endp
; end main


; **************************************** End of Q1 ****************************************************


; **************************************** Start of Q2 ****************************************************

; Write Assembly program to subtract two numbers using variables.

; .data
; var1 db 5
; var2 db 2

; .code
; main proc 
; mov ax , @data
; mov ds , ax

; mov al, var1

; sub al , var2

; mov dl,al
; add dl , 30h ; convert to ascii

; mov ah,02h
; int 21h

; mov ah ,4ch
; int 21h
; main endp
; end main

; **************************************** End of Q2 ****************************************************



; **************************************** Start of Q3 ****************************************************

; mutiply two numbers

; .data
; var1 db 3
; var2 db 3
; result dw 0

; .code
; main proc 
; mov ax, @data
; mov ds, ax

; mov ax, var1
; mul var2
; mov result, ax

; mov dx, result
; add dx, 30h ; convert to ascii

; mov ah, 02h
; int 21h

; mov ah, 4ch
; int 21h
; main endp
; end main

; **************************************** End of Q3 ****************************************************


; **************************************** Start of Q4 ****************************************************

; Write Assembly program to get two single digit numbers from user using variables and add them.

; .data
; var1 db ?
; var2 db ?

; .code
; main proc
; mov ax, @data
; mov ds, ax

; mov ah,01h
; int 21h
; sub al ,'0' ; converting input to numerical value
; mov var1 , al


; mov ah,01h
; int 21h
; sub al ,'0' ; converting input to numerical value
; mov var2 , al

; mov al ,var1
; add al , var2

; mov dl , al
; add dl , 30h

; mov ah , 02h
; int 21h

; mov ah, 4ch
; int 21h

; main endp
; end main

; **************************************** End of Q4 ****************************************************

; **************************************** Start of Q5 ****************************************************

; var4 = (var1 + var2) * var3

.data
var1 db ?
var2 db ?

.code
main proc
mov ax, @data
mov ds, ax

mov ah,01h
int 21h
sub al ,'0' ; converting input to numerical value
mov var1 , al


mov ah,01h
int 21h
sub al ,'0' ; converting input to numerical value
mov var2 , al

mov al ,var1
add al , var2

mov dl , al
add dl , 30h

mov ah , 02h
int 21h

mov ah, 4ch
int 21h

main endp
end main
; **************************************** End of Q5 ****************************************************

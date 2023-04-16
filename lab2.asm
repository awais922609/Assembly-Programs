; Press (control + /) in vscode to uncomment codes.
; LAB 02

; **************************************** Start of Q1 ****************************************************
;1. Write a program to write your name e.g. "AHMED" using 2h interrupt. (hint: use character by character).

.model small
.stack 100h

; .data

; .code
; main proc
; mov dl , 'A'
; mov ah,02h
; int 21h


; mov dl , 'h'
; mov ah,02h
; int 21h

; mov dl , 'm'
; mov ah,02h
; int 21h

; mov dl , 'a'
; mov ah,02h

; int 21h

; mov dl , 'd'
; mov ah,02h
; int 21h

; mov ah,4ch
; int 21h

; main endp
; end main

; end of part 1 


; **************************************** End of Q1 ****************************************************


; ************************************************Start of  Q2 *********************************************************

;2. Write a assembly language program to print hello world using mov ah,02 service routine.

; .data

; .code
; main proc
; mov dl , 'H'
; mov ah,02h
; int 21h


; mov dl , 'e'
; mov ah,02h
; int 21h

; mov dl , 'l'
; mov ah,02h
; int 21h

; mov dl , 'l'
; mov ah,02h
; int 21h

; mov dl , 'o'
; mov ah,02h
; int 21h

; mov dl , ' '
; mov ah,02h
; int 21h

; mov dl , 'W'
; mov ah,02h
; int 21h

; mov dl , 'o'
; mov ah,02h
; int 21h

; mov dl , 'r'
; mov ah,02h
; int 21h

; mov dl , 'l'
; mov ah,02h
; int 21h

; mov dl , 'd'
; mov ah,02h
; int 21h


; mov ah,4ch
; int 21h

; main endp
; end main


; ************************************************End of Q2 *********************************************************




; ************************************************Start of Q3 *********************************************************
;3. Write Assembly program to Input Character from user and display it.

; .data

; .code
; main proc

; mov ah , 01h
; int 21h

; mov dl , al
; ; add dl , 48
; mov ah, 02h
; int 21h

; mov ah,4ch
; int 21h

; main endp
; end main


; ************************************************End of Q3 *********************************************************




; ************************************************Start of Q4 *********************************************************
;4. Write a program that take number and print the next number.

; .data

; .code
; main proc
; mov ah , 01h
; int 21h

; mov dl , al 
; ; sub dl, 'a'

; add dl , 1

; mov ah,02h
; ; mov dl , 0Ah
; ; mov dl , 0Dh
; int 21h

; mov ah,4ch
; int 21h

; main endp
; end main




; ************************************************End of Q4 *********************************************************




; ************************************************Start of Q5 *********************************************************

;5. Write a program that take a number and print the previous number.

; .data
; .code
; main proc

; mov ah,01h
; int 21h

; mov dl , al
; sub dl , 1

; mov ah,02h
; int 21h

; mov ah,4ch
; int 21h

; main endp
; end main


; ************************************************End of Q5 *********************************************************




; ************************************************START of Q6 *********************************************************
;6. Write Assembly program to Input Lower Case letter from user and display it's upper case. (Subtract 32 in ASCII).


; .data
; .code
; main proc
; mov ah,01h
; int 21h

; mov dl , al
; sub dl , 32 ; subtract to convert lowercase to upper and add 32 to convert uppercase to lowercase

; mov ah,02h
; int 21h

; mov ah ,4ch
; int 21h

; main endp
; end main



; ************************************************End of Q6 *********************************************************



; ************************************************Start of Q7 *********************************************************

;8. Write Assembly program to input letter from the user and display the next character.

.data
.code
main proc
mov ah,01h
int 21h

mov dl , al
add dl ,1

mov ah,02h
int 21h

mov ah,4ch
int 21h

main endp
end main


; ************************************************End of Q7 *********************************************************

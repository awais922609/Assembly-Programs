.model small
.stack 100h

;/******************************* Hello World string and Reversing it ********************************************/

; .data
; string1 db 'Hello World $'
; string2 db 'Given string is: $'
; len1 equ $-string1

; .code
; main proc
; mov ax , @data
; mov ds , ax

; ; Print the message "Given string is: "
; mov ah , 09h
; lea dx , string2
; int 21h

; ; Print the string "Hello World"
; mov ah, 09h
; lea dx, string1
; int 21h

; ; Print a newline
; mov ah, 02h
; mov dl, 0dh
; int 21h
; mov dl, 0ah
; int 21h

; ; Reverse the string
; mov si , offset string1 + len1 - 2  ; initialize si to point to second last character of string1
; loop1:
;     cmp si, offset string1 - 1  ; check if si has reached the beginning of the string
;     jb exit
;     mov dl , [si]  ; move the character to dl
;     mov ah,02h
;     int 21h
;     dec si  ; decrement si to point to the previous character
;     jmp loop1

; exit:
;     ; Exit the program
;     mov ah,4ch
;     int 21h
; main endp
; end main

;/******************************* End  Q1 ********************************************/

;/***************************************************************************** Q2 **************************************/
; Write a program that initializes an array with 8 characters and then finds and displays the number of vowels in the array.

; .model small
; .stack 100h

; .data
; arr db 'aeiou vowels$'; 7 vowels (a,e,i,o,u)
; ; arr2 db 'No of vowels are : $'
; len equ ($-arr)
; count dw 0

; .code
; main proc
; mov ax, @data
; mov ds, ax

; mov ah, 09h
; lea dx, arr
; int 21h

; mov si, offset arr
; mov cx, len

; loop1:
;     cmp cx, 0
;     je exit
;     sub cx, 1
;     mov al, [si]
;     cmp al, 'a'
;     je isvowel
;     cmp al, 'e'
;     je isvowel
;     cmp al, 'i'
;     je isvowel
;     cmp al, 'o'
;     je isvowel
;     cmp al, 'u'
;     je isvowel
;     jmp nextchar

; isvowel:
;     inc count
;     jmp nextchar

; nextchar:
;     inc si
;     jmp loop1

; exit:


;     mov ah ,02h
;     mov dl , 0dh
;     int 21h

;     mov ah , 02h
;     mov dl , 0ah
;     int 21h

;     ; mov ah , 09h
;     ; lea dx,arr2
;     ; int 21h

;     mov dx,0
;     mov ah, 02h
;     mov dx, count
;     add dx, 30h
;     int 21h

;     mov ah, 4ch
;     int 21h

; main endp
; end main

;/*****************************************************************************End Q2 **************************************/


;/*****************************************************************************Start Q3 **************************************/
; Write a program that initializes a 3x3 2D array with integers and then finds and displays the sum of the elements in the array.
.data
row_size db 3
columns db 3
arr db 1h,2h,3h
    db 4h,5h,6h
    db 7h,8h,9h
msg1 db 'The array is : ', '$'
len equ ($-arr)
sum dw 0
count db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    mov si, offset arr ; initialize si to point to the start of the array
    mov cx, len ; initialize cx to the length of the array

    mov ah, 09h
    lea dx, msg1
    int 21h

    mov count, 0
    mov bx, 0
outerloop:
    mov bl, 0
innerloop:
    cmp bl, 9
    je exit_innerloop
    mov ah, 02h
    mov dl, byte ptr [si*cl+bx]
    add dl, 30h
    int 21h
    add sum, dx
    add bx, 1
    jmp innerloop

exit_innerloop:
    ; add si, columns
    ; add count, 1
    ; mov al ,count
    ; cmp al, row_size
    ; jne outerloop

    mov ah, 02h
    mov dx, sum
    add dx, 30h
    int 21h
    
    mov ah, 4ch
    int 21h

main endp
end main

;/*****************************************************************************End Q3 **************************************/

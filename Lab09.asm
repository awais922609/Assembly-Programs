; ********************************** SOL Q1 *********************************************

; ******************************** Count no of constants and Vowels *********************************
.model small
.stack 100h

.data
    msg1 db 'Enter a string: $'
    msg2 db 'Number of vowels: $'
    msg3 db 'Number of consonants: $'
    inputStr db 100, '$'
    vowelsCount dw ?
    consonantsCount dw ?

.code
    mov ax, @data
    mov ds, ax

    ; Display message to enter a string
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read user input
    mov ah, 0Ah
    lea dx, inputStr
    int 21h

    ; Call procedure to count vowels and consonants
    lea si, inputStr+2
    call Vowel_Const_Count

    ; Display number of vowels
    mov ah, 09h
    lea dx, msg2
    int 21h
    mov ax, vowelsCount
    call printNumber

    ; Display number of consonants
    mov ah, 09h
    lea dx, msg3
    int 21h
    mov ax, consonantsCount
    call printNumber

    ; Exit program
    mov ah, 4ch
    int 21h

; Procedure to count the number of vowels and consonants in a string
Vowel_Const_Count proc
    mov cx, 0
    mov dx, 0
countLoop:
    mov al, [si]
    cmp al, 0
    je countEnd
    cmp al, 'a'
    jl notLetter
    cmp al, 'z'
    jg notLetter
    cmp al, 'e'
    je isVowel
    cmp al, 'i'
    je isVowel
    cmp al, 'o'
    je isVowel
    cmp al, 'u'
    je isVowel
    cmp al, 'a'
    je isVowel
    jmp notVowel
isVowel:
    inc cx
    jmp nextLetter
notVowel:
    inc dx
    jmp nextLetter
notLetter:
    ; skip non-letter characters
nextLetter:
    inc si
    jmp countLoop
countEnd:
    mov vowelsCount, cx
    mov consonantsCount, dx
    ret
Vowel_Const_Count endp

; Procedure to print a number to the console
printNumber proc
    mov bx, 10
    mov cx, 0
printLoop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne printLoop
printDigits:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop printDigits
    ret
printNumber endp

end


; ********************************** END SOL Q1 *********************************************

; ************************************ Sol Q 2 *********************************************

; .data
;     num dw 5
;     result dw ?
;     counter dw ?

;     firststring db 10h,13h,"Please Enter Number", "$"
;     outputMsg db 'Factorial: $'

; .code
;     main proc
;     mov ax, @data
;     mov ds, ax

; Factorial MACRO num

;         mov result, 1
;         mov counter, num

;         loopStart:
;             cmp counter, 0
;             jle loopEnd
;             mov ax, result
;             mul counter
;             mov result, ax
;             dec counter
;             jmp loopStart

;         loopEnd:
;         endm

;     ; calling the Factorial macro
;     Factorial num

;     mov ah , 09h
;     mov dx , offset firststring
;     int 21h

;     mov num , dx

;     ; print the result
;     exit:
;     mov ah, 09h
;     lea dx, outputMsg
;     int 21h
;     mov ah , 02h
;     mov dx, result
;     add dx, 30h
;     int 21h
;     mov ah ,4ch
;     int 21h


; main endp
; end 

; ************************************** End Sol Q 2 *****************************************
; student struct
;     names db 100 dup(?)
;     age dw ?
;     marks dw ?
; student ends

; .data

; string1 db "Please Enter the name: $"
; newline db 10, 13, "$"
; string2 db "Please Enter Age: $"
; string3 db "Please Enter marks: $"

; .code
; mov ax, @data
; mov ds, ax

; s1 student <>

; ; Reading student name
; mov ah, 09h
; mov dx, offset string1
; int 21h

; mov ah, 0Ah
; mov dx, offset s1.names
; int 21h

; ; Reading student age
; mov ah, 09h
; mov dx, offset string2
; int 21h

; mov ah, 01h
; int 21h
; sub al, 30h
; mov s1.age, ax

; ; Reading student marks
; mov ah, 09h
; mov dx, offset string3
; int 21h

; mov ah, 01h
; int 21h
; sub al, 30h
; mov s1.marks, ax

; ; Displaying student information
; mov ah, 09h
; mov dx, offset s1.names
; int 21h

; mov dl, ','
; mov ah, 02h
; int 21h

; mov ah, 02h
; mov dl, ' '
; int 21h

; mov ax, s1.age
; add ax, 30h
; mov dl, ah
; mov ah, 02h
; int 21h

; mov dl, ','
; mov ah, 02h
; int 21h

; mov ah, 02h
; mov dl, ' '
; int 21h

; mov ax, s1.marks
; add ax, 30h
; mov dl, ah
; mov ah, 02h
; int 21h

; mov ah, 4ch
; int 21h

; end


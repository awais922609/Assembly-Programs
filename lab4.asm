.model small
.stack 100h


; ************************************************* Sol Q1 ***********************************************************
.data
var1 dw ?
var2 dw ?

.code
main proc

mov ax, @data
mov ds, ax

mov ah, 01h
int 21h
mov var1, ax

mov ah, 01h
int 21h
mov var2, ax

mov ax, var1
cmp ax, var2
je L1

mov dl, 'N'
mov ah, 02h
int 21h
jmp exit1

L1:
mov dl, 'Y'
; add dl , 30h
mov ah, 02h
int 21h
jmp exit1

exit1:
mov ah, 4ch
int 21h

main endp
end main


; ************************************************* End Sol Q1 ***********************************************************



; ************************************************* Sol Q2 ***********************************************************
; .data
; var1 db ?
; msg2 db 'The Number is Even$'
; msg3 db 'The Number is Odd$'

; .code
; main proc
; mov ax , @data
; mov ds ,ax

; mov ah,01h
; int 21h

; mov var1 , al
; mov al , var1
; mov bl , 2

; div bl
; cmp ah,0

; jne odd

; mov ah,09h
; lea dx, msg2
; int 21h
; jmp exit1

; odd:
; mov ah,09h
; lea dx , msg3
; int 21h
; jmp exit1

; exit1:
; mov ah,4ch
; int 21h

; main endp
; end main

; ************************************************* End Sol Q2 ***********************************************************


; *************************************************  Sol Q3 **********************************************************
; .data
; var1 db 0
; var2 db 0
; var3 db 255
; var4 db 100
; msg1 db 'The values of variables are $'

; .code 
; main proc
; mov ax, @data
; mov ds, ax 

; mov ah, 01h
; int 21h
; mov var1, al

; mov ah, 01h
; int 21h
; mov var2, al
; mov al, var1

; cmp al, var2 
; jne else
; mov var3, 010h
; jmp exit1

; else:
; mov var3, 6
; mov var4, 7
; jmp exit1

; exit1:
; lea dx, msg1
; mov ah, 09h
; int 21h

; mov dx, var3
; add dx, 30h
; mov ah, 02h
; int 21h

; mov dl, var4
; add dl , 30h
; mov ah, 02h
; int 21h

; jmp end1

; end1:
; mov ah, 4ch
; int 21h

; main endp
; end main


; ************************************************* End Sol Q3 ***********************************************************


; ************************************************* Sol Q4 **********************************************************Q4
; .data

; .code 
; main proc
; mov cx,1

; loop1:
;     cmp cx , 10
;     jae exit

;     mov dl , cl 
;     add dl ,30h
;     mov ah, 02h
;     int 21h
;     add cx,2
;     jmp loop1

; exit:
;     mov ah , 4ch
;     int 21h

; main endp
; end main




; ************************************************* End Sol Q4 ***********************************************************


; ; ************************************************* Sol Q5 ***********************************************************
; .DATA
;   msg1 DB 'Enter obtained marks: $'
;   msg2 DB 'Grade: $'
; .CODE
;   MAIN PROC
;     MOV AX, @DATA
;     MOV DS , AX

;     MOV AH, 09h
;     LEA DX, msg1
;     INT 21H
    
;     MOV AH, 1h
;     INT 21H ; read character from keyboard
;     ; mov dl , al

;     CMP AL, 9 ; compare with 9 (A+)
;     JAE GRADE_A

;     CMP AL, 8 ; compare with 8 (A)
;     JAE GRADE_AM

;     CMP AL, 7 ; compare with 7 (A-)
;     JAE GRADE_BP

;     CMP AL, 6 ; compare with 6 (B)
;     JAE GRADE_B

;     CMP AL, 5 ; compare with 5 (B-)
;     JAE GRADE_BM

;     CMP AL, 4 ; compare with 4 (C+)
;     JAE GRADE_CP

;     JMP FAIL ; else jump to FAIL

; GRADE_A:
;     mov ah , 09h
;     MOV dx, OFFSET msg2
;     int 21h
;     MOV DL, 'A'
;     MOV AH, 02h
;     INT 21H
;     mov dl , '+'
;     mov ah , 02h 
;     int 21h
;     JMP END

; GRADE_AM:
;     mov ah , 09h
;     MOV dl, OFFSET msg2
;     int 21h
;     MOV DL, 'A'
;     MOV AH, 02h
;     INT 21H
;     JMP END

; GRADE_BP:
;     mov ah , 09h
;     MOV dl, OFFSET msg2
;     int 21h
;     MOV DL, 'A'
;     MOV AH, 02h
;     INT 21H
;     mov dl , '-'
;     mov ah , 02h 
;     int 21h
;     JMP END

; GRADE_B:
;     mov ah , 09h
;     MOV dl, OFFSET msg2
;     int 21h
;     MOV DL, 'B'
;     MOV AH, 02h
;     INT 21H
;     JMP END

; GRADE_BM:
;     mov ah , 09h
;     MOV dl, OFFSET msg2
;     int 21h
;     MOV DL, 'B'
;     MOV AH, 02h
;     INT 21H
;     mov dl , '-'
;     mov ah , 02h 
;     int 21h
;     JMP END

; GRADE_CP:
;     mov ah , 09h
;     MOV dl, OFFSET msg2
;     int 21h
;     MOV DL, 'C'
;     MOV AH, 02h
;     INT 21H
;     mov dl , '+'
;     mov ah , 02h 
;     int 21h
;     JMP END

; FAIL:
;     mov ah , 09h
;     MOV dl, OFFSET msg2
;     int 21h
;     MOV DL, 'F'
;     MOV AH, 02h
;     INT 21H
;     JMP END
; END:
;     MOV AH, 4CH
;     INT 21H
;   MAIN ENDP
; END MAIN
; ************************************************* End Sol Q5 ***********************************************************
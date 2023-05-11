; /************************* TASK 1: Setting up Mouse *********************************************************8

; .model small
; .stack 100h
; .data
; prompt1 db 'Mouse not connected!', '$'
; prompt2 db 'Mouse connected, Number of Buttons: ', '$'
; .code
;     main proc
;     mov ax, @data
;     mov ds, ax

;     mov ax, 0
;     int 33h
;     cmp ax, 0
;     jne exit
;     lea dx, prompt1
;     mov ah, 09
;     int 21h
;     jmp end1
;     exit:
;     lea dx, prompt2
;     mov ah, 09
;     int 21h
;     mov dl, bl
;     add dl, 48
;     mov ah, 02
;     int 21h
;     end1:

;     mov AH,4Ch
;     int 21h
;     main endp
; end



; //******************************** Displaying Mouse ***************************************************************
; .model small
; .stack 100h
; .data
; .code
; main proc
;     mov ah, 00h
;     mov al, 13
;     int 10h

;     mov ax, 1
;     int 33h
;     mov cx, 10
;     mov dx, 100
;     mov ax, 4
;     int 33h

;     mov AH,4Ch
;     int 21h
; main endp
; end


; //******************************* Display Pixel on Coordinates ********************************************************

; .model small
; .stack 100h
; .data
; .code
;     main proc
;     ; //  Mouse interrupt 
; ;     Show/Hide Mouse:
; ;    INT 33h, AX = 1 (show), AX = 2 (hide)

;     mov ah, 00h
;     mov al, 13
;     int 10h

;     keepgoing:
;         mov ax, 1
;         int 33h
;         mov ax, 3
;         int 33h
;         mov ah, 0ch
;         mov al, 0fh


;     mov bh, 0h
;     int 10h
;     ;     Get Mouse Position & Status:
;     ; INT 33h, AX = 4
;     mov ax, 4
;     int 33h
;     ;     Get Button Press Information:
;     ; INT 33h, AX = 5
;     mov ax, 5
;     mov bx, 0
;     int 33h
;     cmp ax, 1
;     jne keepgoing

;     mov AH,4Ch
;     int 21h
;     main endp
; end


; //*********************** Finding out key is pressed or not **********************************************************
; //************************  b. Find out which key is pressed *********************************************************
; .model small
; .stack 100h
; .data
; prompt1 db ' was pressed!','$'
; .code

; main proc
;     mov ax, @data
;     mov ds, ax
;     mov ah, 00
;     int 16h
   
;     mov dl, al
;     mov ah, 02
;     int 21h
   
;     lea dx, prompt1
;     mov ah, 09
;     int 21h
;     mov AH,4Ch
;     int 21h
;     main endp
; end



; // TASK 2: Write a program that prints the letter “A”  continuously, it will stop only when Q or q is pressed.

.model small
.stack 100h
.data
.code
    main proc
    mov dl, 65
    
    print:
    
    mov ah, 02
    int 21h
    mov ah, 1
    int 16h
    
    cmp al, 'Q'
    je exit1
    cmp al, 'q'
    
    je exit1
    jmp print
    
    exit1:
    mov AH,4Ch
    int 21h
    main endp
end
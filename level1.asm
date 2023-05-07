include all.inc

.model small
.stack 1024h
.data
    
	;........MENUE PORTION................

textrow db 0 
textcol db 0

	design1 db "|------------------------------------------------|$"
	design2 db " ------------------------------------------------ $"
	
	
	str1 db "|           WELCOME TO AIR XONIX GAME!           |$"

	str2 db "|    PLEASE CHOOSE FROM THE FOLLOWING OPTIONS    |$"
	str3 db "|                    NEW GAME                    |$"
	str4 db "|                     OPTION                     |$"
	str5 db "|                   HIGH SCORE                   |$"
	str6 db "|                   INFORMATION                  |$"	
	str7 db "|                      EXIT                      |$"
	
	
	str8 db "1. Use left 'a', right 'd', up 'w', and down 's' key(s) to move the spaceship around $"
	str9 db "2. Cut off parts of the playing field by moving the spaceship around the grid and drawing lines $"  
	str10 db "3. Fill as many blocks as you can $"
	
	
	str11 db "              PRESS SPACE TO CONTINUE             $"
	
	;str12 db "|                   INFORMATION                  |$"	
	;str13 db "|                      EXIT                      |$"
	
	
	options db 0		; to get user input on what he wants to do
	username db 50 dup ("$")
		
    nameL dw 0
	strP db  "|               GAME IS PAUSED                   |$"
	
    str12 db "|            THANK YOU FOR PLAYING!              |$"
    
	str13 db "|             PRESS ESCAPE TO EXIT               |$"
	str14 db "|             PRESS ENTER TO RESTART             |$"
	str15 db "|            PRESS SPACE TO CONTINUE             |$"	
    
    strS db "Score $"

	bin2 db  "kingsv.wav",0			; we will have to change this later -> to save/read data from 

	
    alien3aKilled db ?
    alien3bKilled db ?
    alien3cKilled db ?

    alien3aX dw ?
    alien3aY dw ?

    alien3bX dw ?
    alien3bY dw ?

    alien3cX dw ?
    alien3cY dw ?

    temp dw ?

    ;; declare all the variables for ship

    leftWingX1 dw ?
    leftWingY1 dw ?
    leftWingX2 dw ?
    leftWingY2 dw ?

    rightWingX1 dw ?
    rightWingY1 dw ?
    rightWingX2 dw ?
    rightWingY2 dw ?

    halfLWingX1 dw ?
    halfLWingY1 dw ?
    halfLWingX2 dw ?
    halfLWingY2 dw ?

    halfRWingX1 dw ?
    halfRWingY1 dw ?
    halfRWingX2 dw ?
    halfRWingY2 dw ?

    downLeftDiagonalX dw ?
    downLeftDiagonalY dw ?

    downRightDiagonalX dw ?
    downRightDiagonalY dw ?

    leftBaseX2 dw ?
    leftBaseY2 dw ?

    rightBaseX2 dw ?
    rightBaseY2 dw ?

    betweenBasesX dw ?
    betweenBasesY dw ?

    leftVerticalX2 dw ?
    leftVerticalY2 dw ?

    rightVerticalX1 dw ?
    rightVerticalY1 dw ?

    upLeftHorizontalX2 dw ?
    upLeftHorizontalY2 dw ?

    upRightHorizontalX2 dw ?
    upRightHorizontalY2 dw ?

    shipX dw ?
	shipY dw ?
    shipC db ?

    black db 0
    red db 4
    blue db 3

    shipColor db ?

    fireX dw ?
    fireY dw ?
    fireLen dw ?
    fireWid dw ?

	
	
	leftBarX1 dw ?
    leftBarY1 dw ?
    leftBarX2 dw ?
    leftBarY2 dw ?
	

	leftUpDiaginalX1 dw ?
	leftUpDiaginalY1 dw ?
	leftUpDiaginalX2 dw ?
	leftUpDiaginalY2 dw ?

	
	UpBarX1 dw ?
	UpBarY1 dw ?
	UpBarX2 dw ?
	UpBarY2 dw ?
	
	
	rightUpDiaginalX1 dw ?
	rightUpDiaginalY1 dw ?
	rightUpDiaginalX2 dw ?
	rightUpDiaginalY2 dw ?
	
	rightBarX1 dw ?
    rightBarY1 dw ?
    rightBarX2 dw ?
    rightBarY2 dw ?
	
	
	rightDownDiaginalX1 dw ?
	rightDownDiaginalY1 dw ?
	rightDownDiaginalX2 dw ?
	rightDownDiaginalY2 dw ?
	
	DownBarX1 dw ?
	DownBarY1 dw ?
	DownBarX2 dw ?
	DownBarY2 dw ?
	
	leftDownDiaginalX1 dw ?
	leftDownDiaginalY1 dw ?
	leftDownDiaginalX2 dw ?
	leftDownDiaginalY2 dw ?
	
	stickX1  dw ?
	stickY1  dw ?
	stickX2  dw ?
	stickY2  dw ?
	
	onerotarX1 dw ?
	onerotarY1 dw ?
	onerotarX2 dw ?
	onerotarY2 dw ?
	
	cout dw ?
	tempX dw ?
	tempY dw ?
	
	;secrotarX1 dw ?
	;secrotarY1 dw ?
	;secrotarX2 dw ?
	;secrotarY2 dw ?




    finished db "Game Over",0

    strCount byte ?
    colno byte ?
    nameColor byte ?

    alien1Killed dw ?

    win db "You Win, On to Level 2",0

    level1 db "LEVEL 1",0

    frame_Y_counter dw ?
    frame_X_counter dw ?

.code

	;...............MENUEPROC.............................
	TextPrint proc 
	T:
		mov  dl,textCol   	;Column
		sub dl,cl
		mov  dh, textRow  	;Row
		mov  bh, 0    		;Display page
		mov  ah, 02h  		;SetCursorPosition
		int  10h
		  
		mov  bh, 0    	;Display page
		mov  bl, 1011b  	;Color is blue
		mov  al, [si]
		mov  ah, 0Eh  
		int  10h
		inc si
	loop T
	ret
	TextPrint endp

	main proc
		
	mov ax, @data
	mov ds, ax

	setVideoMode

	; --------- 1st page design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,4

	call TextPrint
	;..........................................

		mov si,offset str1
		mov cx,lengthof str1
		sub cx,1
		mov textcol,65
		mov textrow,5

	call TextPrint
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,6

	call TextPrint
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,8

	call TextPrint
	;...........................................

		  mov si,offset str2
		  mov cx,lengthof str2
		  sub cx,1
		  mov textcol,65
		  mov textrow,9
		  

	call TextPrint
	;...........................................

		mov si,offset design1
		mov cx,lengthof design1
		sub cx,1
		mov textcol,65
		mov textrow,10

	call TextPrint
	;...........................................

		  mov si,offset str3
		  mov cx,lengthof str3
		  sub cx,1
		  mov textcol,65
		  mov textrow,11
		  

	call TextPrint
	;...........................................

		  mov si,offset str4
		  mov cx,lengthof str4
		  sub cx,1
		  mov textcol,65
		  mov textrow,12
		  

	call TextPrint
	;...........................................

		  mov si,offset str5
		  mov cx,lengthof str5
		  sub cx,1
		  mov textcol,65
		  mov textrow,13
		  

	call TextPrint
	;...........................................

		  mov si,offset str6
		  mov cx,lengthof str6
		  sub cx,1
		  mov textcol,65
		  mov textrow,14
		  

	call TextPrint
	;...........................................

		  mov si,offset str7
		  mov cx,lengthof str7
		  sub cx,1
		  mov textcol,65
		  mov textrow,15
		  

	call TextPrint
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,16

	call TextPrint
	;...........................................

	; ---------- 1st page design ends ----------


	mov dx,13		; skip a line before input
	mov ah,02
	int 21H

	mov dx,10
	mov ah,02
	int 21H


	;...........OPTION INPUT......................

mov ah, 01h         ;; get single char input
int 21h

sub al,30h
mov options, al


cmp options, 1
je new_game

cmp options, 2
je opt

cmp options, 3
je high_score

cmp options, 4
je I2

cmp options, 5
je exit


opt:
mov ah, 02h
mov dl, 'b'
int 21h
clear
jmp exit
;jmp restart0


high_score:
mov ah, 02h
mov dl, 'c'
int 21h
clear
jmp exit
;jmp restart0


;.......CONTINUE...........................

L1:
mov ah,01
int 21h
CMP al,13
JNE L1

;............NEW GAME.....................

;...........NAME INPUT......................

new_game:

start:


    setVideoMode

    gameBoundary

    printGraphicString level1, 15, 35, 1, 2

    call delay

    clear

    setVideoMode

    gameBoundary

    mov shipX, 400
	mov shipY, 410
    main_player_box shipX,shipY, blue
	;ship shipX, red
    ;alien3 50, 100, 2


    .while ah != 1      ;; until escape is entered

		continue:
            .IF alien1Killed == 1
                clear
                setVideoMode
                gameBoundary
                ;alien3 50, 100, 0
                printGraphicString win, 15, 30, 1, 2
                call delay
                call delay
                jmp exit
                
            .ENDIF


        mov ah, 00h         ;; get keyboard input
        int 16h

        .IF ah == 1             ;; escape key
        
            clear
            jmp exit

        .ENDIF

        

        outOfLoop:

        


        .IF (ah == 4DH)       ;; right key pressed
            
                main_player_box shipX,shipY, black
                ;ship shipX, black
				add shipX, 10
				
				mov ax,shipX
				sub ax,10
				mov tempX,ax
				
				mov ax,shipY
				mov tempY,ax
				
				printFrom 3,shipX,shipY,tempX,tempY
				
				mov ax,shipX
				sub ax,15
				mov tempX,ax
				
				mov ax,shipY
				mov tempY,ax
				
				printFrom 3,shipX,shipY,tempX,tempY
				
            .IF (rightBarX2 >= 650)
                mov shipX, 20
            .endif

        .ELSEIF (ah == 4BH)   ;; left key pressed
        
                main_player_box shipX,shipY, black
                ;ship shipX, black
				sub shipX, 10
				
				mov ax,shipX
				add ax,10
				mov tempX,ax
				
				mov ax,shipY
				mov tempY,ax
				
				printFrom 3,shipX,shipY,tempX,tempY
				
            
            .IF (leftBarX1 <= 10 )
            mov shipX, 590
            .endif
			
		.ELSEIF (ah == 48H)   ;; up key pressed
        
                main_player_box shipX,shipY, black
                ;ship shipX, black
				sub shipY, 10
            
				mov ax,shipY
				add ax,20
				mov tempY,ax
				
				mov ax,shipX
				mov tempX,ax
				
				printFrom 3,shipX,shipY,tempX,tempY
				
			
            .IF (onerotarY2 <= 0 )
            mov shipY, 420
            .endif
			
		.ELSEIF (ah == 50H)   ;; down key pressed
        
                main_player_box shipX,shipY, black
                ;ship shipX, black
				add shipY, 10
				
				mov ax,shipY
				sub ax,20
				mov tempY,ax
				
				mov ax,shipX
				mov tempX,ax
				
				printFrom 3,shipX,shipY,tempX,tempY
            
            .IF (DownBarY2 >= 470 )
            mov shipY, 60
            .endif

        .ENDIF


        draw:
        ;ship shipX, red
		main_player_box shipX,shipY, blue

    .endw

jmp exit	

	

	;jmp exit
;..........................................

;.............INFORMATION PAGE.............

I2:

	mov ah,00h
	mov al,10h
	int 10h


	mov si,offset str6
	mov cx,lengthof str6
	sub cx,1
	mov textcol,65
	mov textrow,5

	call TextPrint

;................INSTRUCTION 1............................

	mov ah, 02h  ; Set cursor position
	mov bh, 0    ; Display page number
	mov dh, 8   ; Row
	mov dl, 10   ; Column
	int 10h      ; Call ISR

	mov si, offset str8
	mov ah, 09h ; set function code to print string
	mov dx, si ; load address of string into dx
	mov bl, 01h ; set the attribute to 01h, which is blue text on black background
	int 21h ; call interrupt to print string
	
	;call TextPrint

;................INSTRUCTION 2............................

	mov ah, 02h  ; Set cursor position
	mov bh, 0    ; Display page number
	mov dh, 11   ; Row
	mov dl, 10   ; Column
	int 10h      ; Call ISR
	
    mov si, offset str9
	mov ah, 09h ; set function code to print string
	mov dx, si ; load address of string into dx
	mov bl, 01h ; set the attribute to 01h, which is blue text on black background
	int 21h ; call interrupt to print string

    ;call TextPrint

;................INSTRUCTION 3............................


    mov ah, 02h  ; Set cursor position
	mov bh, 0    ; Display page number
	mov dh, 14   ; Row
	mov dl, 10   ; Column
	int 10h      ; Call ISR

    mov si, offset str10
	mov ah, 09h ; set function code to print string
	mov dx, si ; load address of string into dx
	mov bl, 01h ; set the attribute to 01h, which is blue text on black background
	int 21h ; call interrupt to print stringt
	
;................INSTRUCTION 4........................

	;mov ah,00h
	;mov al,10h
	;int 10h


	mov si,offset str11
	mov cx,lengthof str11
	sub cx,1
	mov textcol,65
	mov textrow,18

	call TextPrint
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;              ENTER CONTINUE
	
	.while ah != 1      ;; until escape is entered
		
		mov ah, 00h         ;; get keyboard input
        int 16h

        .IF ah == 1             ;; escape key
        
            clear
            jmp exit

        .ENDIF
		
		.IF (ah == 57)             ;; space key
        
            clear
            jmp main

        .ENDIF
	
	.endw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    delay proc
        pushAll

        mov cx,1000
        mydelay:
            mov bx,750      ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
            mydelay1:
            dec bx
            jnz mydelay1
        loop mydelay

        popall

    ret
    delay endp


    


    
exit:
	; printing the menu
	
	;clear
	
	; --------- 1st page design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,4

	call TextPrint
	;..........................................

		mov si,offset strP
		mov cx,lengthof strP
		sub cx,1
		mov textcol,65
		mov textrow,5

	call TextPrint
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,6

	call TextPrint
	;...........................................

		mov si,offset str12
		mov cx,lengthof str12
		sub cx,1
		mov textcol,65
		mov textrow,8

	call TextPrint
	;...........................................

		  mov si,offset design2
		  mov cx,lengthof design2
		  sub cx,1
		  mov textcol,65
		  mov textrow,9
		  

	call TextPrint
	;...........................................

		  mov si,offset str2
		  mov cx,lengthof str2
		  sub cx,1
		  mov textcol,65
		  mov textrow,10
		  

	call TextPrint
	;...........................................

		mov si,offset design1
		mov cx,lengthof design1
		sub cx,1
		mov textcol,65
		mov textrow,11

	call TextPrint
	;...........................................

		  mov si,offset str13
		  mov cx,lengthof str13
		  sub cx,1
		  mov textcol,65
		  mov textrow,12
		  

	call TextPrint
	;...........................................

		  mov si,offset str14
		  mov cx,lengthof str14
		  sub cx,1
		  mov textcol,65
		  mov textrow,13
		  

	call TextPrint
	;...........................................

		  mov si,offset str15
		  mov cx,lengthof str15
		  sub cx,1
		  mov textcol,65
		  mov textrow,14
		  

	call TextPrint
	
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,15

	call TextPrint 
	;...........................................

	; ---------- exit page design ends ----------


	mov dx,13		; skip a line before input
	mov ah,02
	int 21H

	mov dx,10
	mov ah,02
	int 21H


		;...........OPTION INPUT......................
	mov ax,0

	.while ah != 1      ;; until escape is entered
		
		mov ah, 00h         ;; get keyboard input
        int 16h

        .IF ah == 1             ;; escape key
        
            clear
            jmp exit1

        .ENDIF
		
		.IF (ah == 2)             ;; enter key
        
            clear
            jmp new_game

        .ENDIF
		
		
		.IF (ah == 57)             ;; space key
        
            clear
            jmp new_game

        .ENDIF
		
	
	.endw




exit1:
mov ah,4ch
int 21h
    
main endp
end main
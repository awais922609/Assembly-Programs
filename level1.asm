include all.inc ;contains a list of constants, macros, and other declarations used in the program.
																						;  ERROR WITH LINE 506
.model large ; 1 MB of memory. 
;.MODEL FLAT, STDCALL 
.stack 1024h
.data
;PROT32 ; Enable 32-bit addressing mode
    
	;........MENUE PORTION................

timer_1 dw 0     ; variable to store timer value
secondsPassed db 0  ; variable to store result of Check60Seconds macro
textrow db 0 
textcol db 0

	design1 db "|************************************************|$"
	design2 db "************************************************** $"
	
	
	welcome db "|           WELCOME TO AIR XONIX GAME!           |$"
	enter_name db "             PLEASE ENTER YOUR NAME =            $"
	choose db "|    PLEASE CHOOSE FROM THE Given Options    |$"
	new_game_var db "|                    NEW GAME                    |$"
	option_var db "|                     OPTION                     |$"
	high_score_var db "|                   HIGH SCORE                   |$"
	info_var db "|                   INFORMATION                  |$"	
	str7 db "|                      EXIT                      |$"
	newline db 0Ah , 0Dh , "$"
	
	info_var2 db "1. Use left '<-', right '->', up '|>', and down '<|' key(s) to move the spaceship around $"
	info_var3 db "2. Cut off parts of the playing field by moving the spaceship around the grid and drawing lines $"  
	info_var4 db "3. Make Space you own color by moving on it"
	
	
	str11 db "              PRESS SPACE TO CONTINUE             $"
	
	
	
	options db 0		; to get user input on what he wants to do
	username db 15 dup (" ")
		
    nameL dw 0
	str_paused db  "|               GAME IS PAUSED                   |$"
	
    str_thank db "|            THANK YOU FOR PLAYING!              |$"
    
	str13 db "|             PRESS ESCAPE TO EXIT               |$"
	str14 db "|             PRESS ENTER TO RESTART             |$"
	str15 db "|            PRESS SPACE TO CONTINUE             |$"


	str_congrats db  "|               CONGRATULATIONS                  |$"
	str_level2 db  "|               Welcome to Level 2                  |$"


    str27 db "|              LEVEL 1 COMPLETE                  |$"
    
	str28 db "|             PRESS ESCAPE TO EXIT               |$"
	str29 db "|             PRESS ENTER TO Proceed             |$"
	
    
    str_score db "Score $"
	str_per db "percent $"

	bin2 db  "kingsv.wav",0			; we will have to change this later -> to save/read data from 


    temp dw ?


	; //**************** Ship decleration Starts Here **************************************//
    heroX dw ?
	heroY dw ?
    shipC db ?

    blue db 3

; // **************************** Grid Decleration goes here **************************//

	leftBarX1 dw ?
    leftBarY1 dw ?
    leftBarX2 dw ?
    leftBarY2 dw ?
	

	
	UpBarX1 dw ?
	UpBarY1 dw ?
	UpBarX2 dw ?
	UpBarY2 dw ?
	
	
	rightBarX1 dw ?
    rightBarY1 dw ?
    rightBarX2 dw ?
    rightBarY2 dw ?
	
	
	DownBarX1 dw ?
	DownBarY1 dw ?
	DownBarX2 dw ?
	DownBarY2 dw ?
	
	
; // **************************** Grid Decleration ends here **************************//

	

    finished db "Game Over",0

    strCount byte ?
    colno byte ?
    nameColor byte ?


    win db "You Win, On to Level 2",0

    level1 db "LEVEL 1",0
	level2 db "LEVEL 2",0


	; // **************** Keeping track of no fo frames in x and y direction ********************

    frame_Y_counter dw ?
    frame_X_counter dw ?
	
	; // **************** Keeping track of no fo frames in x and y direction ends here********************
	
	
; pLAYER Lives remainging and place of the icon position
	player_life dw 3
	life_x dw 0
    life_y dw 10
	lives_dots db 0Eh ; storing color values
	


; /**************************** Enemy variables decleration ***********************************/
	ball_1x dw 200
	ball_1y dw 200
	ball_2x dw 100
	ball_2y dw 100
	ball_3x dw 100
	ball_3y dw 100
	ball_direction dw 1
	ball_direction1 dw 4
	ball_direction2 dw 2

; /**************************** Enemy variables decleration ***********************************/


	player_death dw 0
	restarting dw 0
	restarting1 dw 0
	restarting2 dw 0
	
	color db ?
	prev_x dw 0
	prev_y dw 0
	
	total_x dw 600 
	total_y dw 460 
	total_pixels dw 0
	total_pixels_ dw 12000
	findcolor db 3
	percent dw 0
	percent_counter dw 0
	highscore dw 100
	
	block_x dw 110
	block_y dw 150
	
	block_2x dw 440
	block_2y dw 150
	
	block_3x dw 150
	block_3y dw 250
	
	block_4x dw 490
	block_4y dw 250
	
	
	number dw 56
    buffer_for_digits dw 5 dup ('$')  ; buffer_for_digits to hold the digits
	buffer_for_digits1 dw 5 dup ('$')  ; buffer_for_digits to hold the digits
    digit db ?             ; variable to hold each digit
    count db 0             ; counter for the number of digits
	

	

.code

	;...............MENUEPROC.............................
	TextPrint proc 
	T:
		mov  dl,textCol   	;Column which is currently 0
		sub dl,cl
		mov  dh, textRow  	;Row
		mov  bh, 0    		;Display page in case of 13h it is 1 page only
		mov  ah, 02h  		;SetCursorPosition
		int  10h
		  
		mov  bh, 0    	;Display page
		mov  bl, 1010b  	;Color is blue//1011
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
;....................MENUE1....................

I1:

restart0:

;set video mode
mov ah,00h
mov al,10h
int 10h


	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1 ;s othat it comes to the end
	mov textcol,65
	mov textrow,5

call TextPrint
;...........................................

	mov si,offset welcome
	mov cx,lengthof welcome
	sub cx,1
	mov textcol,65
	mov textrow,6

call TextPrint
;........................................... Making Design ****************************************************

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,7

call TextPrint


;........................................... Making Design Ends Here ****************************************************
;...........................................



      mov si,offset enter_name ; WELCOME TO AIR XONIX
      mov cx,lengthof enter_name
      sub cx,1
      mov textcol,55
      mov textrow,11

call TextPrint
;...........................................

;...........NAME INPUT......................
mov dx,0 ;.........counter

mov si,offset username ; 30 CHARACTERS MAX
loop1:
mov ah,01
int 21h
mov [si],al
inc si
inc dx
cmp al,13 ; ascii of enter
JNE loop1
mov nameL,dx


menu:

;set video mode
mov ah,00h
mov al,10h
int 10h



; --------- MENU PAGE design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,7

call TextPrint
;...........................................

      mov si,offset choose
      mov cx,lengthof choose
      sub cx,1
      mov textcol,65
      mov textrow,8
	  

call TextPrint
;...........................................

	mov si,offset design1
	mov cx,lengthof design1
	sub cx,1
	mov textcol,65
	mov textrow,9

call TextPrint
;...........................................

      mov si,offset new_game_var
      mov cx,lengthof new_game_var
      sub cx,1
      mov textcol,65
      mov textrow,10
	  

call TextPrint
;...........................................

      mov si,offset option_var
      mov cx,lengthof option_var
      sub cx,1
      mov textcol,65
      mov textrow,11
	  

call TextPrint
;...........................................

      mov si,offset high_score_var
      mov cx,lengthof high_score_var
      sub cx,1
      mov textcol,65
      mov textrow,12
	  

call TextPrint
;...........................................

      mov si,offset info_var
      mov cx,lengthof info_var
      sub cx,1
      mov textcol,65
      mov textrow,13
	  

call TextPrint
;...........................................

      mov si,offset str7
      mov cx,lengthof str7
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

;----------- 1st page design ends ----------


mov dl , newline
mov ah ,02h 
int 21h


;...........OPTION INPUT......................

mov ah,00 ; keyboard key press
int 16h


cmp al,'1'	
	je start2

cmp al,'2'	
	je opt

cmp al,'3'	
	je high_score

cmp al,'4'	
	je I2

cmp al,'5'
	je exit


jmp new_game2

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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                                                                            ; level 2
																			
;............level1.....................

;.................................

new_game2:
start2:

	mov percent ,0
	mov player_life,3
	mov player_death,0
	mov highscore,100

    VideoMode
	

    gameBoundary ; declaaring 4 side game boundary
	
	; //****************** Printing Level1 here on mid of screen ***********************************
	StringPrinting level1, 15, 35, 2,2 ; 15 , 35 is thee mid  24 rows 80 columnnns

	
    call delay

    clear

    VideoMode ; calling again for moving to clear screen and drawing game boundary

    gameBoundary

	; //*************** Printing username on screen *****************************
	StringPrinting username, 0, 30, 1, 0Eh
   

	; // starting position of ships 
	mov heroX, 400
	mov heroY, 400
	
	;       blocks 
	draw_block block_x,block_y,2 ; position along with specified color
	draw_block block_2x,block_2y,2
	draw_block block_3x,block_3y,2
	draw_block block_4x,block_4y,2
	
	
	
	;       main_player

    main_player_box heroX,heroY, 9
		
		
	; //********************* Player Lives being shown here *********************************************//

	.if(player_life>0)

        add life_x,40
        draw_life life_x,life_y,lives_dots ;Players Life icons to be shown here
        sub life_x,40
    
    .endif

    .if(player_life>1)

        add life_x,50
        draw_life life_x,life_y,lives_dots ;Players Life icons to be shown here
        sub life_x,50
    
    .endif

    .if(player_life>2)

        add life_x,60
        draw_life life_x,life_y,lives_dots ;Players Life icons to be shown here
        sub life_x,60
    
    .endif

	; //********************* Player Lives being shown here ends here *********************************************//

	

; Check60Seconds timer_1
; mov [secondsPassed], ax


	mov ax,0
    .while ah != 1      ;; until escape is entered
	
		resume2:

		
		; .if(percent >= 90 && secondsPassed>=60)
		
		.if(percent >= 50)
			clear
			jmp winpage
		.endif
		.if(player_death == 3)
			jmp losepage
			;jmp exit
		.endif
	
	    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    
			mov si, offset buffer_for_digits
			
			;mov ax,highscore 
			mov ax,highscore
				
			;stores value in buffer_for_digits
			CALL PRINT   
						
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; hightscore
		
		StringPrinting str_score, 0, 50, 1, 4
	
		StringPrinting buffer_for_digits, 0, 56, 1, 4
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		    
			mov si, offset buffer_for_digits1
			
			.if(percent_counter == 13)
				inc percent
				mov percent_counter,0
			.endif
			
			mov ax,percent
				
			;stores value in buffer_for_digits
			CALL PRINT   
						
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; percentage
	
		StringPrinting str_per, 0, 64, 1, 4
		
		StringPrinting buffer_for_digits1, 0, 72, 1, 4
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
		
	
		.if(player_life>0)

			add life_x,40
			draw_life life_x,life_y,lives_dots ;Players Life icons to be shown here
			sub life_x,40
		
		.endif

		.if(player_life>1)

			add life_x,50
			draw_life life_x,life_y,lives_dots ;Players Life icons to be shown here
			sub life_x,50
		
		.endif

		.if(player_life>2)

			add life_x,60
			draw_life life_x,life_y,lives_dots ;Players Life icons to be shown here
			sub life_x,60
		
		.endif

		.if(player_death==3)

			add life_x,40
			draw_life life_x,life_y,0 ;Players Life icons to be shown here
			sub life_x,40
			jmp exit
		
		.endif

		.if(player_death==2)

			add life_x,50
			draw_life life_x,life_y,0 ;Players Life icons to be shown here
			sub life_x,50
		
		.endif

		.if(player_death==1)

			add life_x,60
			draw_life life_x,life_y,0 ;Players Life icons to be shown here
			sub life_x,60
		
		.endif
	
	
		; /************************ enemies Drawing ******************************************************
		main_player_box ball_1x,ball_1y, 4
		main_player_box ball_2x,ball_2y, 4
		; main_player_box ball_3x,ball_3y, 4
			

		; /************************ enemies Drawing Ends here ******************************************************

		; //*********************** Logic for enemies not passing through hurdles ****************************

		mov bx,1000
		
        .while(bx>0)
        
            nop                 ;For Delay in movement of ball
            dec bx
        
        .endw
		
		; //*********************** Logic for enemies not passing through hurdles  ends here****************************
		;enemy1 movement x-axis, y-axis , movement =1 , life , death , restarting
		ball_movement ball_1x,ball_1y,ball_direction,player_life,player_death,restarting ; stopping

        pop ball_direction		
		
		mov bx,ball_direction

        cmp bx,1
        je dir1_

        cmp bx,2
        je dir2_

        cmp bx,3
        je dir3_

        cmp bx,4
        je dir4_


		dir1_:

			main_player_box ball_1x,ball_1y, 0
			add ball_1x,4
			sub ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_;stopping
		
		dir2_:

			main_player_box ball_1x,ball_1y, 0
			sub ball_1x,4
			sub ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_

		dir3_:
				
			main_player_box ball_1x,ball_1y, 0
			sub ball_1x,4
			add ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_

		dir4_:

			main_player_box ball_1x,ball_1y, 0
			add ball_1x,4
			add ball_1y,4
			main_player_box ball_1x,ball_1y, 4
			jmp keychecks_
		
		
		keychecks_:
		
		ball_movement ball_2x,ball_2y,ball_direction1,player_life,player_death,restarting1

        pop ball_direction1

		mov bx,ball_direction1

        cmp bx,1
        je dir11_

        cmp bx,2
        je dir12_

        cmp bx,3
        je dir13_

        cmp bx,4
        je dir14_


		dir11_:

			main_player_box ball_2x,ball_2y, 0
			add ball_2x,2
			sub ball_2y,2
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_
		
		dir12_:

			main_player_box ball_2x,ball_2y, 0
			sub ball_2x,2
			sub ball_2y,2
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_

		dir13_:
				
			main_player_box ball_2x,ball_2y, 0
			sub ball_2x,2
			add ball_2y,2
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_

		dir14_:

			main_player_box ball_2x,ball_2y, 0
			add ball_2x,2
			add ball_2y,2
			main_player_box ball_2x,ball_2y, 4
			jmp keychecks1_

		keychecks1_:
		

		;*******************************************************************************************************
		
		; ball_movement ball_3x,ball_3y,ball_direction2,player_life,player_death,restarting2

        ; pop ball_direction2

		; mov bx,ball_direction2

        ; cmp bx,1
        ; je dir31_

        ; cmp bx,2
        ; je dir32_

        ; cmp bx,3
        ; je dir33_

        ; cmp bx,4
        ; je dir34_


		; dir31_:

		; 	main_player_box ball_3x,ball_3y, 0
		; 	add ball_3x,2
		; 	sub ball_3y,2
		; 	main_player_box ball_3x,ball_3y, 4
		; 	jmp keychecks2_
		
		; dir32_:

		; 	main_player_box ball_3x,ball_3y, 0
		; 	sub ball_3x,2
		; 	sub ball_3y,2
		; 	main_player_box ball_3x,ball_3y, 4
		; 	jmp keychecks2_

		; dir33_:
				
		; 	main_player_box ball_3x,ball_3y, 0
		; 	sub ball_3x,2
		; 	add ball_3y,2
		; 	main_player_box ball_3x,ball_3y, 4
		; 	jmp keychecks2_

		; dir34_:

		; 	main_player_box ball_3x,ball_3y, 0
		; 	add ball_3x,2
		; 	add ball_3y,2
		; 	main_player_box ball_3x,ball_3y, 4
		; 	jmp keychecks2_

		; keychecks2_:
		


		;***********************************************************************************************
		mov ah,1
		int 16h

		jz resume2 

		
		


        mov ah, 00h         ;; get keyboard input
        int 16h
		
		

        .IF ah == 1             ;; escape key
			clear
            jmp exit

        .ENDIF

		.IF (ah == 57)   ;; space key pressed
        
            jmp game_pause2
				
        .ENDIF


        .IF (ah == 4DH)       ;; right key pressed
            
                main_player_box heroX,heroY, blue
                ;ship heroX, black
				add heroX, 10
				
				inc percent_counter
				add highscore,10
				
            .IF (rightBarX2 >= 610)
                ;mov heroX, 30                     ; for passing through walls
				sub heroX, 10                      ; for stoping at walls 
            .endif

        .ELSEIF (ah == 4BH)   ;; left key pressed
        
                main_player_box heroX,heroY, blue
                ;ship heroX, black
				sub heroX, 10
				
				add highscore,10
				inc percent_counter
            
            .IF (leftBarX1 <= 40 )
			
				;mov heroX, 600                  ; for passing through walls
				add heroX,10
            .endif
			
		.ELSEIF (ah == 48H)   ;; up key pressed
        
                main_player_box heroX,heroY, blue
                ;ship heroX, black
				sub heroY, 10
            
				add highscore,10
				inc percent_counter
			
            .IF (UpBarY1 <= 60 )
				;mov heroY, 420
				add heroY,10
            .endif
			
		.ELSEIF (ah == 50H)   ;; down key pressed
        
                main_player_box heroX,heroY, blue
                ;ship heroX, black
				add heroY, 10
				
				add highscore,10
				inc percent_counter
			
            .IF (DownBarY2 >= 450 )
                ;mov heroY, 60
				sub heroY,10
            .endif

		.endif


        draw2:
        ;ship heroX, red
		main_player_box heroX,heroY, 8
		
		jmp resume2
		
		game_pause2:

        mov ah,1
        int 16h

        jz game_pause2

        mov ah,00h
        int 16h

        cmp al,' '
        je resume2

        jmp game_pause2

    .endw

jmp exit	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;..........................................

;.............INFORMATION PAGE.............

I2:

	mov ah,00h
	mov al,10h
	int 10h


	mov si,offset info_var
	mov cx,lengthof info_var
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

	mov si, offset info_var2
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
	
    mov si, offset info_var3
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

    mov si, offset info_var4
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

winpage:
	
    ; --------- 1st page design starts ---------

	mov si,offset design2
	mov cx,lengthof design2
	sub cx,1
	mov textcol,65
	mov textrow,4

	call TextPrint
	;..........................................

		mov si,offset str_congrats
		mov cx,lengthof str_congrats
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

		mov si,offset design1
		mov cx,lengthof design1
		sub cx,1
		mov textcol,65
		mov textrow,9

	call TextPrint
	;...........................................

		  mov si,offset str27
		  mov cx,lengthof str13
		  sub cx,1
		  mov textcol,65
		  mov textrow,10
		  

	call TextPrint
	;...........................................

		  mov si,offset str28
		  mov cx,lengthof str28
		  sub cx,1
		  mov textcol,65
		  mov textrow,11
		  

	call TextPrint
	;...........................................

		  mov si,offset str29
		  mov cx,lengthof str29
		  sub cx,1
		  mov textcol,65
		  mov textrow,12
		  

	call TextPrint
	
	;...........................................

		mov si,offset design2
		mov cx,lengthof design2
		sub cx,1
		mov textcol,65
		mov textrow,13

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
		
		.IF (ah == 1Ch)             ;; enter key
        
            clear
            jmp new_game2

        .ENDIF
		
	
	.endw

losepage:

    StringPrinting finished, 15, 35, 1, 2
	
	StringPrinting str_score, 17, 34, 1, 2
	
	StringPrinting buffer_for_digits, 17, 40, 1, 2

    call delay
	call delay
	call delay
	call delay
	call delay

    clear
	
	;jmp menu
	jmp main
    
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

		mov si,offset str_paused
		mov cx,lengthof str_paused
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

		mov si,offset str_thank
		mov cx,lengthof str_thank
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

		  mov si,offset choose
		  mov cx,lengthof choose
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
		
		.IF (ah == 1Ch)             ;; enter key
        
            clear
            jmp new_game2 ; here

        .ENDIF
		
		
		.IF (ah == 57)             ;; space key
        
            clear
            jmp resume2

        .ENDIF
		
	
	.endw




exit1:
mov ah,4ch
int 21h
    
main endp

PRINT PROC          
     
    ;initialize count
    mov cx,0
    mov dx,0
    label1:
        ; if ax is zero
        cmp ax,0
        je print1    
         
        ;initialize bx to 10
        mov bx,10       
         
        ; extract the last digit
        div bx                 
         
        ;push it in the stack
        push dx             
         
        ;increment the count
        inc cx             
         
        ;set dx to 0
        xor dx,dx
        jmp label1
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit2
         
        ;pop the top of stack
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
         
        ;interrupt to print a
        ;character
		mov [si],dx
        inc si
         
        ;decrease the count
        dec cx
        jmp print1
exit2:
ret
PRINT ENDP


; /********************************** percentage Proc *******************************************************
percentage proc 

	mov bx,total_x
	mov dx,total_y
	mov cx,0
	.while(bx != 0)
			
		.while(dx != 0)
			
			; read color at current position
			mov ah, 0Dh
			mov cx, total_x                 ; hit down wall
			mov dx, total_y
			add dx,17
			int 10H ; AL = COLOR
			
			.if (al == findcolor)
				
				add cx,1
				
			.endif
			
			add total_pixels,1
	
		.endw
	
	
	.endw
	
	mov ax,cx
	
	; Calculate the percentage of blue pixels
    mov bx, 100 ; Multiply by 100 to get percentage
    mul bx ; AX = blue_count * 100
    
	mov cx,total_pixels
	div cx ; AX = blue_count * 100 / total_pixels
    mov percent, ax
	
	push percent
ret
percentage endp

; /********************************** percentage Proc Ends here *******************************************************

end main



; /************************ TOTAL HARDWORK OF COAL ****************************************

; .model small
; .stack 100h

; .data
; ; Initialize variables
; grid_width     dw 20
; grid_height    dw 20
; user_x         dw 10
; user_y         dw 10
; enemy_x        dw 5
; enemy_y        dw 5
; score          dw 0

; enemy_direction dw ?
; timer dw ?
; ; Define the file handle variable
; file_handle dw ?
; user_life dw 3
; ; Define the name of the file where the score will be saved
; score_file_name db 'score.txt', 0

; .code
;     main proc
;     mov ax, @data
;     mov ds , ax
;     ; Set up the game
;     call initialize_game
;     call draw_grid
;     call draw_cells
; ; Draw the user and enemy
;     call draw_user
;     call draw_enemy

;     ; Start the game loop
;     mov ah, 00h     ; set function to get system time
;     int 1Ah         ; call interrupt
;     mov [timer], dx ; store current time in timer variable
    
;     call game_loop
    
;     ; End the game
;     ; call end_game
;     ; jmp $           ; Hang indefinitely

; initialize_game:
;     ; Set up the video mode
;     mov ax, 13h
;     int 10h
    
;     ; Set up the timer
;     ; mov ax, 0B800h  ; Set segment to video memory
;     ; mov es, ax
;     ; mov bx, 184Eh   ; Set cursor position to upper right corner
;     ; mov al, timer/10 + '0'
;     ; stosw           ; Write first digit of time remaining
;     ; mov al, timer mod 10 + '0'
;     ; stosw           ; Write second digit of time remaining
    
    
;     ; Set up the grid
;     ; Set up the grid
;     ret

; game_loop:
;     ; update the timer
;     call update_timer
    
;     ; move the enemy randomly
;     call move_enemy_random
    
;     ; handle user input
;     call handle_input
    
;     ; check for collision
;     call check_collision
    
;     ; check if game is over
;     mov ax , timer
;     cmp ax, 0
;     jne game_loop   ; If time remains, continue the game
;     jmp end_game    ; Otherwise, end the game
    
; ; Draws the grid on the screen
; draw_grid:
;     mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
;     mov al, 176          ; AL=176: ASCII code for a shaded block character
;     mov bh, 0            ; BH=0: Page number (0 for the text screen)
    
;     ; Draw horizontal borders
;     mov cx, [grid_width] ; CX=grid_width: Number of columns in the grid
;     mov dl, 186          ; DL=186: ASCII code for a vertical border character
;     mov dh, 0            ; DH=0: Row number for the top border
;     int 10h              ; Draw top border
;     mov dh, [grid_height] ; DH=grid_height: Row number for the bottom border
;     int 10h              ; Draw bottom border
    
;     ; Draw vertical borders
;     mov cx, [grid_height] ; CX=grid_height: Number of rows in the grid
;     mov dl, 205            ; DL=205: ASCII code for a horizontal border character
;     mov dh, 1              ; DH=1: Row number for the left border
;     mov bh, 0              ; BH=0: Page number (0 for the text screen)
;     mov dx, 0              ; DX=0: Column number for the left border
;     int 10h                ; Draw left border
;     mov dx, [grid_width]   ; DX=grid_width: Column number for the right border
;     int 10h                ; Draw right border
    
;     ; Draw grid cells
;     mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
;     mov al, 32           ; AL=32: ASCII code for a space character (to clear the cells)
;     mov bh, 0            ; BH=0: Page number (0 for the text screen)
;     mov dh, 2            ; DH=2: Starting row number for the cells
;     mov dx, 1            ; DX=1: Starting column number for the cells
;     ret

; .draw_cells:
;     int 10h              ; Draw a cell
;     inc dx              ; Move to the next column
;     cmp dx, [grid_width] ; If all columns have been drawn, move to the next row
;     jne .draw_cells
;     inc dh              ; Move to the next row
;     mov dx, 1            ; Reset column number to 1
;     cmp dh, [grid_height] ; If all rows have been drawn, return
;     jne .draw_cells
    
;     ret
    
; ; Draws the user on the screen
; draw_user:
;     mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
;     mov al, 2            ; AL=2: Color code for the user
;     mov bh, 0            ; BH=0: Page number
;     mov cx, [user_x]     ; Move user_x into CX
;     mov dx, [user_y]     ; Move user_y into DX
;     mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
;     ; mov al, 2            ; AL=2: Color code for the user
;     mov al, 1Fh
;     mov bh, 0            ; BH=0: Page number
;     int 10h              ; Call interrupt 10h to change the color of the user
;     ret

; draw_enemy:
;     mov cx, [enemy_x]    ; Move enemy_x into CX
;     mov dx, [enemy_y]    ; Move enemy_y into DX
;     mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
;     mov al, 4            ; AL=4: Color code for the enemy
;     mov bh, 0            ; BH=0: Page number
;     int 10h              ; Call interrupt 10h to change the color of the enemy
;     ret

; end_game:
;     ; Write the score to a file
;     mov ah, 3Ch      ; Create or open file
;     mov cx, 0        ; Attribute (normal)
;     lea dx, score_file_name
;     int 21h
;     mov file_handle, ax
    
;     mov ah, 40h      ; Write to file
;     mov bx, file_handle
;     mov cx, 2        ; Number of bytes to write
;     lea dx, score
;     int 21h
    
;     mov ah, 3Eh      ; Close file
;     mov bx, file_handle
;     int 21h
    
;     ; Return to DOS
;     mov ah, 4Ch
;     int 21h
;     ret

;  update_timer:

;     mov ah, 2            ; AH=2: BIOS function to print a character on the screen
;     mov bh, 0            ; BH=0: Page number
;     mov dl, 'T'          ; DL='T' character
;     mov cx, 70           ; CX=70: X position of the cursor
;     mov dx, 0            ; DX=0: Y position of the cursor
;     int 10h              ; Call interrupt 10h to print 'T' on the screen

    
;     ; // **************** Time Implementation ****************************//
;     mov ah, 00h     ; set function to get system time
;     int 1Ah         ; call interrupt
;     mov [timer], dx ; store current time in timer variable
;     mov ah, 00h     ; set function to get system time
;     int 1Ah         ; call interrupt
;     sub dx, [timer] ; subtract previous time from current time
;     cmp dx, 3C0h     ; compare with 60 seconds (60 * 18.2 = 3Ch hex)
;     jg end_game    ; if less than 60 seconds, continue
    
;     ; Display the remaining time
;     mov ah, 2            ; AH=2: BIOS function to print a character on the screen
;     mov bh, 0            ; BH=0: Page number
;     mov dl, [timer]  ; Move timer into DL
;     add dl, '0'          ; Convert timer to its ASCII representation
;     mov cx, 72           ; CX=72: X position of the cursor
;     mov dx, 0            ; DX=0: Y position of the cursor
;     int 10h              ; Call interrupt 10h to print the remaining time on the screen
    
;     ret

;     ; ; Decrement timer by 1
;     ; mov ax , timer
;     ; sub ax , 1
;     ; ; store the updated timer value
;     ; mov bx, offset timer
;     ; mov [bx], ax
;     ; ret
   

; handle_input:
;     ; Check for keypress
;     mov ah, 1
;     int 21h
    
;     ; Move user based on keypress
;     cmp al, 27h      ; Check if ESC key is pressed
;     je end_game
    
;     cmp al, 48h      ; Check if '0' key is pressed
;     je end_game
    
;     cmp al, 4Bh      ; Check if left arrow key is pressed
;     je move_user_left
    
;     cmp al, 4Dh      ; Check if right arrow key is pressed
;     je move_user_right
    
;     cmp al, 48h      ; Check if up arrow key is pressed
;     je move_user_up
    
;     cmp al, 50h      ; Check if down arrow key is pressed
;     je move_user_down
    
;     jmp handle_input    ; If no arrow key is pressed, continue the game loop
    

; move_user_left:
;     ; Move the user left by decrementing user_x by 1
;     sub word ptr [user_x], 1
;     call draw_user
;     jmp check_collision

; move_user_right:
;     ; Move the user right by incrementing user_x by 1
;     add word ptr [user_x], 1
;     call draw_user
;     jmp check_collision

; move_user_up:
;     ; Move the user up by decrementing user_y by 1
;     sub word ptr [user_y], 1
;     call draw_user
;     jmp check_collision

; move_user_down:
;     ; Move the user down by incrementing user_y by 1
;     add word ptr [user_y], 1
;     call draw_user
;     jmp check_collision

; move_enemy_random:
;     ; Generate a random direction for the enemy
;     mov ah, 0             ; AH=0: BIOS function to get the system timer
;     int 1Ah               ; Call interrupt 1Ah to get the system timer
;     mov dx, dx            ; Move DX into DX to divide it by 256
;     mov ax, dx            ; Move DX into AX
;     mov bx, 4             ; BX=4: Maximum value for the random direction (1-4)
;     div bx                ; Divide AX by BX to get a random number between 0 and 3
;     inc ax                ; Increment AX to get a random number between 1 and 4
;     mov [enemy_direction], ax ; Move the random direction into enemy_direction
    
;     ; Move the enemy based on the random direction
;     cmp ax, 1             ; Compare AX to 1 (move up)
;     je move_enemy_up      ; Jump to move_enemy_up if AX equals 1
;     cmp ax, 2             ; Compare AX to 2 (move down)
;     je move_enemy_down    ; Jump to move_enemy_down if AX equals 2
;     cmp ax, 3             ; Compare AX to 3 (move left)
;     je move_enemy_left    ; Jump to move_enemy_left if AX equals 3
;     cmp ax, 4             ; Compare AX to 4 (move right)
;     je move_enemy_right   ; Jump to move_enemy_right if AX equals 4
;     ret                   ; Return if the random direction is invalid
    
; move_enemy_up:
;     ; Move the enemy up
;     dec word ptr [enemy_y]
;     ret
    
; move_enemy_down:
;     ; Move the enemy down
;     inc word ptr [enemy_y]
;     ret
    
; move_enemy_left:
;     ; Move the enemy left
;     dec word ptr [enemy_x]
;     ret
    
; move_enemy_right:
;     ; Move the enemy right
;     inc word ptr [enemy_x]
;     ret


; check_collision:
;     ; Load the x and y positions of the user and enemy
;     mov cx, [user_x]
;     mov dx, [user_y]
;     mov bx, [enemy_x]
;     mov ax, [enemy_y]

;     ; Check if the user and enemy are on the same axis
;     cmp cx, bx
;     jne check_collision_end
;     cmp dx, ax
;     jne check_collision_end

;     ; If they are, subtract 1 from the user's life and reset the game if necessary
;     sub [user_life], 1
;     cmp [user_life], 0
;     jne check_collision_end
;     call end_game

; check_collision_end:
;     ; ret
;     jmp game_loop


; .end:
;     ret



; main endp
; end main
   

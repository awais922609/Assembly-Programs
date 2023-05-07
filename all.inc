box macro x, y, len, wid, color

    mov si, x          
    mov di, y          

    .while di < len
    
        mov si, x

            .while si < wid
                
                printPixel color, si, di
                inc si
                
            .endw
        
        inc di
    
    .endw

endm

printPixel macro color, xAxis, yAxis

    mov ah, 0ch
    mov al, color
    mov cx, xAxis
    mov dx, yAxis
    int 10h

endm

printFrom macro color, from_x, from_y, to_x , to_y

    mov si, from_x
    mov di, from_y

    ;; when si is less than to_x and di is less than to_y   ; diagonal top to bottom
    .IF si < to_x && di < to_y 
    
            .while temp != 0
            printPixel color, si, di

                .IF si < to_x && di < to_y
                    inc si
                    inc di
                .ELSEIF si < to_x
                    inc si
                .ELSEIF di < to_y
                    inc di
                .ELSE
                    mov temp, 0
                .ENDIF
    
    .endw

    ;; when si is less than to_x and di is greater than to_y
    .ELSEIF si < to_x && di > to_y
    
            .WHILE temp != 0 
            printPixel color, si, di

                .IF si < to_x && di > to_y
                    inc si
                    dec di
                .ELSEIF si < to_x
                    inc si
                .ELSEIF di > to_y
                    dec di
                .ELSE
                    mov temp, 0
                .ENDIF

    .ENDW

    ;; when si is greater than to_x and di is less than to_y
    .ELSEIF si > to_x && di < to_y
    
            .WHILE temp != 0
            printPixel color, si, di

                .IF si > to_x && di < to_y
                    dec si
                    inc di
                .ELSEIF si > to_x
                    dec si
                .ELSEIF di < to_y
                    inc di
                .ELSE
                    mov temp, 0
                .ENDIF
    .endw

    ;; when si is greater than to_x and di is greater than to_y
    .ELSEIF si > to_x && di > to_y
    
            .WHILE temp != 0
            printPixel color, si, di

                    .IF si > to_x && di > to_y
                        dec si
                        dec di
                    .ELSEIF si > to_x
                        dec si
                    .ELSEIF di > to_y
                        dec di
                    .ELSE
                        mov temp, 0
                    .ENDIF
            .ENDW

    .ELSEIF si == to_x && di == to_y
        printPixel color, si, di 
    
    .ELSEIF si == to_x && di < to_y
        
        printPixel color, si, di
        
        inc di
        .WHILE di < to_y
            printPixel color, si, di
            inc di
        .ENDW
    
    .ELSEIF si == to_x && di > to_y
        
        printPixel color, si, di
        
        dec di
        .WHILE di > to_y
            printPixel color, si, di
            dec di
        .ENDW

    .ELSEIF si < to_x && di == to_y
            
            printPixel color, si, di
            
            inc si
            .WHILE si < to_x
                printPixel color, si, di
                inc si
            .ENDW

    .ELSEIF si > to_x && di == to_y
                
                printPixel color, si, di
                
                dec si
                .WHILE si > to_x
                    printPixel color, si, di
                    dec si
                .ENDW
    
    .ENDIF

    mov si, 0
    mov di, 0
    mov temp, 1
    mov al, 0

endm

setVideoMode macro

    mov ah, 0
    mov al, 12h
    int 10h

endm

triangle macro color, x1, y1, x2, y2, x3, y3

    printFrom color, x1, y1, x2, y2
    printFrom color, x2, y2, x3, y3
    printFrom color, x3, y3, x1, y1

endm


defaultLeftValues macro

    mov leftBarX1, 620
    mov leftBarY1, 420
    mov leftBarX2, 620
    mov leftBarY2, 430
	

	mov leftUpDiaginalX1,620
	mov leftUpDiaginalY1,420
	mov leftUpDiaginalX2,630
	mov leftUpDiaginalY2,410

	
	mov UpBarX1, 630
	mov UpBarY1, 410
	mov UpBarX2, 640
	mov UpBarY2, 410
	
	
	mov rightUpDiaginalX1, 640
	mov rightUpDiaginalY1, 410
	mov rightUpDiaginalX2, 650
	mov rightUpDiaginalY2, 420
	
	mov rightBarX1, 650
    mov rightBarY1, 420
    mov rightBarX2, 650
    mov rightBarY2, 430
	
	
	mov rightDownDiaginalX1, 650
	mov rightDownDiaginalY1, 430
	mov rightDownDiaginalX2, 640
	mov rightDownDiaginalY2, 440
	
	mov DownBarX1, 640
	mov DownBarY1, 440
	mov DownBarX2, 630
	mov DownBarY2, 440
	
	mov leftDownDiaginalX1, 630
	mov leftDownDiaginalY1, 440
	mov leftDownDiaginalX2, 620
	mov leftDownDiaginalY2, 430
	
	mov stickX1 , 635
	mov stickY1 , 420
	mov stickX2 , 635
	mov stickY2 , 405
	
	mov onerotarX1 , 620
	mov onerotarY1 , 395
	mov onerotarX2 , 650
	mov onerotarY2 , 410
	
	mov secrotarX1 , 620
	mov secrotarY1 , 410
	mov secrotarX2 , 650
	mov secrotarY2 , 395
	

endm


defaultRightValues macro

	
    mov leftBarX1, 620
    mov leftBarY1, 420
    mov leftBarX2, 620
    mov leftBarY2, 430
	

	mov leftUpDiaginalX1,620
	mov leftUpDiaginalY1,420
	mov leftUpDiaginalX2,630
	mov leftUpDiaginalY2,410

	
	mov UpBarX1, 630
	mov UpBarY1, 410
	mov UpBarX2, 640
	mov UpBarY2, 410
	
	
	mov rightUpDiaginalX1, 640
	mov rightUpDiaginalY1, 410
	mov rightUpDiaginalX2, 650
	mov rightUpDiaginalY2, 420
	
	mov rightBarX1, 650
    mov rightBarY1, 420
    mov rightBarX2, 650
    mov rightBarY2, 430
	
	
	mov rightDownDiaginalX1, 650
	mov rightDownDiaginalY1, 430
	mov rightDownDiaginalX2, 640
	mov rightDownDiaginalY2, 440
	
	mov DownBarX1, 640main
	mov DownBarY1, 440
	mov DownBarX2, 630
	mov DownBarY2, 440
	
	mov leftDownDiaginalX1, 630
	mov leftDownDiaginalY1, 440
	mov leftDownDiaginalX2, 620
	mov leftDownDiaginalY2, 430
	
	mov stickX1 , 635
	mov stickY1 , 420
	mov stickX2 , 635
	mov stickY2 , 405
	
	mov onerotarX1 , 620
	mov onerotarY1 , 395
	mov onerotarX2 , 650
	mov onerotarY2 , 410
	
	mov secrotarX1 , 620
	mov secrotarY1 , 410
	mov secrotarX2 , 650
	mov secrotarY2 , 395
	
	
	
    



endm


main_player_box macro xAxis , yAxis , shipColor   

    mov di, xAxis
	mov si, yAxis
	
	
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
    mov leftBarX1, di	; left bar
	mov leftBarY1, si 	
    

    mov leftBarX2, di       
	mov leftBarY2, si
	add leftBarY2, 15

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov UpBarX1, di
	mov UpBarY1, si
	
	mov UpBarX2, di 	;; UpBarX2 = xAxis + 10
    add UpBarX2, 15    
	mov UpBarY2, si
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	mov rightBarX1, di 	;; rightBarX1 = xAxis + 10
    add rightBarX1, 15    
	mov rightBarY1, si    
	
	mov rightBarX2, di 	;; rightBarX2 = xAxis + 10
    add rightBarX2, 15    
	mov rightBarY2, si     ;; rightbarY2 = yAxis + 10
	add rightBarY2, 15
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov DownBarX1, di 	;; DownBarX1 = xAxis + 10
    add DownBarX1, 15   
	mov DownBarY1, si     ;; DownBarY1 = xAxis + 10
	add DownBarY1, 15
	
	mov DownBarX2, di 	
	mov DownBarY2, si     ;; DownBarY2 = yAxis + 10
	add DownBarY2, 15
	
	
	

    ; .IF leftBarX1 <= 10  ;; if moves out of left of screem
    ;     defaultRightValues
    ; .ELSEIF rightBarX2 >= 620  ;; if moves out of right of screem
    ;     defaultLeftValues
    ; .ENDIF
    


    printFrom shipColor, leftBarX1, leftBarY1, leftBarX2, leftBarY2     ;; left horizontal Bar
    
	mov bx,15
	
	.while(bx != 0) ;2<7
        
            printFrom shipColor, UpBarX1, UpBarY1, UpBarX2, UpBarY2    ;; UpBar
	
			add UpBarY1,1
			add UpBarY2,1
			
			sub bx,1

    .endw
	
	
    
	
    printFrom shipColor, rightBarX1, rightBarY1, rightBarX2, rightBarY2    ;; rightBar
    
	printFrom shipColor, DownBarX1, DownBarY1, DownBarX2, DownBarY2      ;; DownBar
	
	    

endm



clear macro
    mov ax,03h
    int 10h
endm



delayfire macro
        push ax
        push bx
        push cx
        push dx

        mov cx,1000
        my1:
            mov bx,5      ;; increase this number if you want to add more delay, and decrease this number if you want to reduce delay.
            my2:
            dec bx
            jnz my2
        loop my1

        pop dx
        pop cx
        pop bx
        pop ax
endm







printGraphicString macro string, row, col, space, color

    push si
    push di

    mov si, offset string
    mov colno, col
    mov strCount, 0
    ; mov nameColor, color

    .while strCount != lengthof string

        mov ah,2    ;mov cursor to specific position
        mov bh,0    ;page no = 0
        mov dh,row   ;mov to row#
        mov dl,colno   ;mov to column#
        int 10h	    ;print graphic

        mov ah,9    ;print char w.r.t attributes
        mov al,[si]  ;character to print
        mov bl,color  ;attributes
        mov bh,0	;page number
        mov cx,1	;times of printing
        int 10h		;print graphics

        add colno, space
        inc si
        inc strCount
    .endw

    pop di
    pop si

endm


popall macro
    pop dx
    pop cx
    pop bx
    pop ax
endm

pushAll macro
    push ax
    push bx
    push cx
    push dx
endm


gameBoundary macro
    mov frame_Y_counter, 30

    .REPEAT
        printPixel 3, 30, frame_Y_counter
		printPixel 3, 31, frame_Y_counter
		printPixel 3, 32, frame_Y_counter
		printPixel 3, 33, frame_Y_counter
		printPixel 3, 34, frame_Y_counter
		printPixel 3, 35, frame_Y_counter
		printPixel 3, 36, frame_Y_counter
		printPixel 3, 37, frame_Y_counter
		printPixel 3, 38, frame_Y_counter
		printPixel 3, 39, frame_Y_counter
		printPixel 3, 40, frame_Y_counter
        inc frame_Y_counter
    .UNTIL frame_Y_counter == 460

    mov frame_X_counter, 30

    .REPEAT
        printPixel 3, frame_X_counter, frame_y_counter
		printPixel 3, frame_X_counter, 451
		printPixel 3, frame_X_counter, 452
		printPixel 3, frame_X_counter, 453
		printPixel 3, frame_X_counter, 454
		printPixel 3, frame_X_counter, 455
		printPixel 3, frame_X_counter, 456
		printPixel 3, frame_X_counter, 457
		printPixel 3, frame_X_counter, 458
		printPixel 3, frame_X_counter, 459
		printPixel 3, frame_X_counter, 460
        inc frame_X_counter
    .UNTIL frame_X_counter == 615

    .REPEAT
        printPixel 3, frame_X_counter, frame_y_counter
		printPixel 3, 611, frame_y_counter
		printPixel 3, 612, frame_y_counter
		printPixel 3, 613, frame_y_counter
		printPixel 3, 614, frame_y_counter
		printPixel 3, 615, frame_y_counter
		printPixel 3, 616, frame_y_counter
		printPixel 3, 617, frame_y_counter
		printPixel 3, 618, frame_y_counter
		printPixel 3, 619, frame_y_counter
		printPixel 3, 620, frame_y_counter
        dec frame_y_counter
    .UNTIL frame_y_counter == 30

    .REPEAT
        printPixel 3, frame_X_counter, frame_y_counter
		printPixel 3, frame_X_counter,  31
		printPixel 3, frame_X_counter,  32
		printPixel 3, frame_X_counter,  33
		printPixel 3, frame_X_counter,  34
		printPixel 3, frame_X_counter,  35
		printPixel 3, frame_X_counter,  36
		printPixel 3, frame_X_counter,  37
		printPixel 3, frame_X_counter,  38
		printPixel 3, frame_X_counter,  39
		printPixel 3, frame_X_counter,  40
        dec frame_X_counter
    .UNTIL frame_X_counter == 30

endm





rectangle macro color, x1, y1, x2, y2, x3, y3,x4,y4

    printFrom color, x1, y1, x2, y2
    printFrom color, x2, y2, x3, y3
    printFrom color, x3, y3, x4, y4
	printFrom color, x4, y4, x1, y1

endm



main_player_box_1 macro p1,p2,c ;life icons for player

push p1 ;2
push p2 ;2

mov bx,p1 ;2
add bx,15    ;7

    .while(p1<bx) ;2<7
        
        push bx
        mov bx,p2
        add bx,15
        push p2 

        .while(p2<bx) ;2<7
        
            Mov CX,p1
            Mov DX,p2

            Mov Al,c
            Mov AH,0CH
            int 10H

            ADD p2,1

        .endw

        pop p2
        pop bx
        ADD p1,1

    .endw

pop p2
pop p1

endm

draw_life macro p1,p2,c ;life icons for player

push p1 ;2
push p2 ;2

mov bx,p1 ;2
add bx,5    ;7

    .while(p1<bx) ;2<7
        
        push bx
        mov bx,p2
        add bx,5
        push p2 

        .while(p2<bx) ;2<7
        
            Mov CX,p1
            Mov DX,p2

            Mov Al,c
            Mov AH,0CH
            int 10H

            ADD p2,1

        .endw

        pop p2
        pop bx
        ADD p1,1

    .endw

pop p2
pop p1

endm

draw_block macro p1,p2,c ;life icons for player

push p1 ;2
push p2 ;2

mov bx,p1 ;2
add bx,30    ;7

    .while(p1<bx) ;2<7
        
        push bx
        mov bx,p2
        add bx,5
        push p2 

        .while(p2<bx) ;2<7
        
            Mov CX,p1
            Mov DX,p2

            Mov Al,c
            Mov AH,0CH
            int 10H

            ADD p2,1

        .endw

        pop p2
        pop bx
        ADD p1,1

    .endw

pop p2
pop p1

endm

ball_movement macro x_point, y_point, ball_dir, player_life, player_death, restarting
    .if(ball_dir==1)
	
        ; read color at current position
        mov ah, 0Dh
        mov cx, x_point               ; hit up wall
        mov dx, y_point
		sub dx, 2
        int 10H ; AL = COLOR

        ; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		
		
		; check if blue
        .if (al==3)
			mov ball_dir,4
		.ENDIF
		
		; read color at current position
        mov ah, 0Dh
        mov cx, x_point           ; hit right wall
		add cx, 17
        mov dx, y_point
        int 10H ; AL = COLOR

        ; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		
		
		; check if blue
        .if (al==3)
			mov ball_dir,2
		.ENDIF

        .if(x_point>=590)
            mov ball_dir,2
        .endif
        
        .if (y_point<=40)
            mov ball_dir,4
        .endif

    .elseif(ball_dir==2)
        ; read color at current position
        mov ah, 0Dh
        mov cx, x_point               ; hit left wall
		sub cx,2
        mov dx, y_point
        int 10H ; AL = COLOR

		; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		

        ; check if blue
        .if (al==3)
			mov ball_dir,1
		.ENDIF
		
		; read color at current position
        mov ah, 0Dh
        mov cx, x_point                         ;hit up wall
        mov dx, y_point
		sub dx,2
        int 10H ; AL = COLOR

		; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		

        ; check if blue
        .if (al==3)
			mov ball_dir,3
		.ENDIF
		
		
        .if(y_point<=40)
            mov ball_dir,3
        .endif

        .if(x_point<=40)
            mov ball_dir,1
        .endif

    .elseif(ball_dir==3)
        ; read color at current position
        mov ah, 0Dh
        mov cx, x_point                ; hit down wall
        mov dx, y_point
		add dx,17
        int 10H ; AL = COLOR
		
		; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		
        ; check if blue
        .if (al==3)
			mov ball_dir,2
		.ENDIF
		
		; read color at current position
        mov ah, 0Dh
        mov cx, x_point
		sub cx,2                            ; hit left wall
        mov dx, y_point
        int 10H ; AL = COLOR
		
		; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		
        ; check if blue
        .if (al==3)
			mov ball_dir,4
		.ENDIF
		
        .if(x_point<=40)
            mov ball_dir,4
        .endif

        .if(y_point>=440)
            mov ball_dir,2
            ;dec player_life
            ;inc player_death
            ;mov restarting,0
            ;jmp l1
        .endif

    .elseif(ball_dir==4)
        ; read color at current position
        mov ah, 0Dh
        mov cx, x_point                 ; hit right wall
		add cx,17
        mov dx, y_point
        int 10H ; AL = COLOR

        ; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		
		; check if blue
        .if (al==3)
			mov ball_dir,3
		.ENDIF
		
		; read color at current position
        mov ah, 0Dh
        mov cx, x_point                 ; hit down wall
        mov dx, y_point
		add dx,17
        int 10H ; AL = COLOR
		
		; check if player
        .if (al==8)
			sub highscore,500
			dec player_life
			inc player_death
			defaultballValues
		.ENDIF
		
		; check if blue
        .if (al==3)
			mov ball_dir,1
		.ENDIF
		
        .if(x_point>=590)
            mov ball_dir,3
        .endif

        .if(y_point>=440)
            mov ball_dir,1
            ;dec player_life
            ;inc player_death
            ;mov restarting,0
            ;jmp l1
        .endif

    .endif

    push ball_dir

endm

defaultballValues macro

	mov ball_1x, 200
	mov ball_1y, 200
	mov ball_2x, 100
	mov ball_2y, 100
	mov ball_direction, 1
	mov ball_direction1, 4
	
endm


draw_bricks macro life, x1, y1, x2, y2 ; Life/Status of the Brick, x1 y1 top left points, x2 y2 bottom right points

    push x1
    push y1
    push x2
    push y2

    mov bx,x2

    .while(x1<bx)
        
        push bx
        mov bx,y2
        push y1
        .while(y1<bx)
        
            Mov CX,x1
            Mov DX,y1

            Mov Al,life
            Mov AH,0CH
            int 10H

            ADD y1,1

        .endw

        pop y1
        pop bx
        ADD x1,1

    .endw

.if(life==0)

        pop y2
        pop x2
        pop y1
        pop x1
        mov x1,0
        mov x2,0
        mov y1,0
        mov y2,0
.else

        pop y2
        pop x2
        pop y1
        pop x1

.endif
            
endm
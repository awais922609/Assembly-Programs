.model small
.stack 100h

.data
; Initialize variables
grid_width     dw 20
grid_height    dw 20
user_x         dw 10
user_y         dw 10
enemy_x        dw 5
enemy_y        dw 5
score          dw 0

enemy_direction dw ?
timer dw ?
; Define the file handle variable
file_handle dw ?
user_life dw 3
; Define the name of the file where the score will be saved
score_file_name db 'score.txt', 0

.code
    main proc
    mov ax, @data
    mov ds , ax
    ; Set up the game
    call initialize_game
    call draw_grid

; Draw the user and enemy
    call draw_user
    call draw_enemy

    ; Start the game loop
    mov ah, 00h     ; set function to get system time
    int 1Ah         ; call interrupt
    mov [timer], dx ; store current time in timer variable
    
    call game_loop
    
    ; End the game
    call end_game
    jmp $           ; Hang indefinitely

initialize_game:
    ; Set up the video mode
    mov ax, 13h
    int 10h
    
    ; Set up the timer
    ; mov ax, 0B800h  ; Set segment to video memory
    ; mov es, ax
    ; mov bx, 184Eh   ; Set cursor position to upper right corner
    ; mov al, timer/10 + '0'
    ; stosw           ; Write first digit of time remaining
    ; mov al, timer mod 10 + '0'
    ; stosw           ; Write second digit of time remaining
    
    
    ; Set up the grid
    ; Set up the grid
    ret

game_loop:
    ; update the timer
    call update_timer
    
    ; move the enemy randomly
    call move_enemy_random
    
    ; handle user input
    call handle_input
    
    ; check for collision
    call check_collision
    
    ; check if game is over
    mov ax , timer
    cmp ax, 0
    jne game_loop   ; If time remains, continue the game
    jmp end_game    ; Otherwise, end the game
    
; Draws the grid on the screen
draw_grid:
    mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
    mov al, 176          ; AL=176: ASCII code for a shaded block character
    mov bh, 0            ; BH=0: Page number (0 for the text screen)
    
    ; Draw horizontal borders
    mov cx, [grid_width] ; CX=grid_width: Number of columns in the grid
    mov dl, 186          ; DL=186: ASCII code for a vertical border character
    mov dh, 0            ; DH=0: Row number for the top border
    int 10h              ; Draw top border
    mov dh, [grid_height] ; DH=grid_height: Row number for the bottom border
    int 10h              ; Draw bottom border
    
    ; Draw vertical borders
    mov cx, [grid_height] ; CX=grid_height: Number of rows in the grid
    mov dl, 205            ; DL=205: ASCII code for a horizontal border character
    mov dh, 1              ; DH=1: Row number for the left border
    mov bh, 0              ; BH=0: Page number (0 for the text screen)
    mov dx, 0              ; DX=0: Column number for the left border
    int 10h                ; Draw left border
    mov dx, [grid_width]   ; DX=grid_width: Column number for the right border
    int 10h                ; Draw right border
    
    ; Draw grid cells
    mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
    mov al, 32           ; AL=32: ASCII code for a space character (to clear the cells)
    mov bh, 0            ; BH=0: Page number (0 for the text screen)
    mov dh, 2            ; DH=2: Starting row number for the cells
    mov dx, 1            ; DX=1: Starting column number for the cells
    ret

.draw_cells:
    int 10h              ; Draw a cell
    inc dx              ; Move to the next column
    cmp dx, [grid_width] ; If all columns have been drawn, move to the next row
    jne .draw_cells
    inc dh              ; Move to the next row
    mov dx, 1            ; Reset column number to 1
    cmp dh, [grid_height] ; If all rows have been drawn, return
    jne .draw_cells
    
    ret
    
; Draws the user on the screen
draw_user:
    mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
    mov al, 2            ; AL=2: Color code for the user
    mov bh, 0            ; BH=0: Page number
    mov cx, [user_x]     ; Move user_x into CX
    mov dx, [user_y]     ; Move user_y into DX
    mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
    ; mov al, 2            ; AL=2: Color code for the user
    mov al, 1Fh
    mov bh, 0            ; BH=0: Page number
    int 10h              ; Call interrupt 10h to change the color of the user
    ret

draw_enemy:
    mov cx, [enemy_x]    ; Move enemy_x into CX
    mov dx, [enemy_y]    ; Move enemy_y into DX
    mov ah, 0Ch          ; AH=0Ch: BIOS function to change the color of a single character
    mov al, 4            ; AL=4: Color code for the enemy
    mov bh, 0            ; BH=0: Page number
    int 10h              ; Call interrupt 10h to change the color of the enemy
    ret

end_game:
    ; Write the score to a file
    mov ah, 3Ch      ; Create or open file
    mov cx, 0        ; Attribute (normal)
    lea dx, score_file_name
    int 21h
    mov file_handle, ax
    
    mov ah, 40h      ; Write to file
    mov bx, file_handle
    mov cx, 2        ; Number of bytes to write
    lea dx, score
    int 21h
    
    mov ah, 3Eh      ; Close file
    mov bx, file_handle
    int 21h
    
    ; Return to DOS
    mov ah, 4Ch
    int 21h
    ret

 update_timer:

    
    mov ah, 2            ; AH=2: BIOS function to print a character on the screen
    mov bh, 0            ; BH=0: Page number
    mov dl, 'T'          ; DL='T' character
    mov cx, 70           ; CX=70: X position of the cursor
    mov dx, 0            ; DX=0: Y position of the cursor
    int 10h              ; Call interrupt 10h to print 'T' on the screen

    
    ; // **************** Time Implementation ****************************//
    mov ah, 00h     ; set function to get system time
    int 1Ah         ; call interrupt
    sub dx, [timer] ; subtract previous time from current time
    cmp dx, 3C0h     ; compare with 60 seconds (60 * 18.2 = 3Ch hex)
    jg end_game    ; if less than 60 seconds, continue
    
    ; Display the remaining time
    mov ah, 2            ; AH=2: BIOS function to print a character on the screen
    mov bh, 0            ; BH=0: Page number
    mov dl, [timer]  ; Move timer into DL
    add dl, '0'          ; Convert timer to its ASCII representation
    mov cx, 72           ; CX=72: X position of the cursor
    mov dx, 0            ; DX=0: Y position of the cursor
    int 10h              ; Call interrupt 10h to print the remaining time on the screen
    
    ret

    ; ; Decrement timer by 1
    ; mov ax , timer
    ; sub ax , 1
    ; ; store the updated timer value
    ; mov bx, offset timer
    ; mov [bx], ax
    ; ret
   

handle_input:
    ; Check for keypress
    mov ah, 1
    int 21h
    
    ; Move user based on keypress
    cmp al, 27h      ; Check if ESC key is pressed
    je end_game
    
    cmp al, 48h      ; Check if '0' key is pressed
    je end_game
    
    cmp al, 4Bh      ; Check if left arrow key is pressed
    je move_user_left
    
    cmp al, 4Dh      ; Check if right arrow key is pressed
    je move_user_right
    
    cmp al, 48h      ; Check if up arrow key is pressed
    je move_user_up
    
    cmp al, 50h      ; Check if down arrow key is pressed
    je move_user_down
    
    jmp game_loop    ; If no arrow key is pressed, continue the game loop
    
move_user_left:
    ; Move the user left by decrementing user_x by 1
    sub word ptr [user_x], 1
    call draw_user
    jmp game_loop

move_user_right:
    ; Move the user right by incrementing user_x by 1
    add word ptr [user_x], 1
    call draw_user
    jmp game_loop

move_user_up:
    ; Move the user up by decrementing user_y by 1
    sub word ptr [user_y], 1
    call draw_user
    jmp game_loop

move_user_down:
    ; Move the user down by incrementing user_y by 1
    add word ptr [user_y], 1
    call draw_user
    jmp game_loop

move_enemy_random:
    ; Generate a random direction for the enemy
    mov ah, 0             ; AH=0: BIOS function to get the system timer
    int 1Ah               ; Call interrupt 1Ah to get the system timer
    mov dx, dx            ; Move DX into DX to divide it by 256
    mov ax, dx            ; Move DX into AX
    mov bx, 4             ; BX=4: Maximum value for the random direction (1-4)
    div bx                ; Divide AX by BX to get a random number between 0 and 3
    inc ax                ; Increment AX to get a random number between 1 and 4
    mov [enemy_direction], ax ; Move the random direction into enemy_direction
    
    ; Move the enemy based on the random direction
    cmp ax, 1             ; Compare AX to 1 (move up)
    je move_enemy_up      ; Jump to move_enemy_up if AX equals 1
    cmp ax, 2             ; Compare AX to 2 (move down)
    je move_enemy_down    ; Jump to move_enemy_down if AX equals 2
    cmp ax, 3             ; Compare AX to 3 (move left)
    je move_enemy_left    ; Jump to move_enemy_left if AX equals 3
    cmp ax, 4             ; Compare AX to 4 (move right)
    je move_enemy_right   ; Jump to move_enemy_right if AX equals 4
    ret                   ; Return if the random direction is invalid
    
move_enemy_up:
    ; Move the enemy up
    dec word ptr [enemy_y]
    ret
    
move_enemy_down:
    ; Move the enemy down
    inc word ptr [enemy_y]
    ret
    
move_enemy_left:
    ; Move the enemy left
    dec word ptr [enemy_x]
    ret
    
move_enemy_right:
    ; Move the enemy right
    inc word ptr [enemy_x]
    ret


check_collision:
    ; Load the x and y positions of the user and enemy
    mov cx, [user_x]
    mov dx, [user_y]
    mov bx, [enemy_x]
    mov ax, [enemy_y]

    ; Check if the user and enemy are on the same axis
    cmp cx, bx
    jne check_collision_end
    cmp dx, ax
    jne check_collision_end

    ; If they are, subtract 1 from the user's life and reset the game if necessary
    sub [user_life], 1
    cmp [user_life], 0
    jne check_collision_end
    call end_game

check_collision_end:
    ret


.end:
    ret



main endp
end main
   

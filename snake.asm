org 100h

section .text

start:
    mov ah, 0
    mov al, 3
    int 10h

    mov si, msg
    mov bl, 12
    call print_centered

.wait_key:
.wait_loop:
    mov ah, 0
    int 16h
    cmp al, 13
    jne .wait_loop

    mov ah, 0
    mov al, 3
    int 10h

    mov byte [x], 40
    mov byte [y], 12
    mov byte [dir], 'D'

    call draw_snake

game_loop:
    call delay

    mov ah, 01h
    int 16h
    jz .move_snake

    mov ah, 00h
    int 16h

    cmp al, 'w'
    je .set_up
    cmp al, 's'
    je .set_down
    cmp al, 'a'
    je .set_left
    cmp al, 'd'
    je .set_right
    jmp .move_snake

.set_up:    mov byte [dir], 'U'
            jmp .move_snake
.set_down:  mov byte [dir], 'D'
            jmp .move_snake
.set_left:  mov byte [dir], 'L'
            jmp .move_snake
.set_right: mov byte [dir], 'R'

.move_snake:
    call erase_snake

    mov al, [dir]
    cmp al, 'U'
    jne .chk_down
    dec byte [y]
    jmp .after_move
.chk_down:
    cmp al, 'D'
    jne .chk_left
    inc byte [y]
    jmp .after_move
.chk_left:
    cmp al, 'L'
    jne .chk_right
    dec byte [x]
    jmp .after_move
.chk_right:
    cmp al, 'R'
    jne .after_move
    inc byte [x]
.after_move:

    mov al, [x]
    cmp al, 0
    jb game_over
    cmp al, 79
    ja game_over

    mov al, [y]
    cmp al, 0
    jb game_over
    cmp al, 24
    ja game_over

    call draw_snake

    jmp game_loop

game_over:
    mov ah, 0
    mov al, 3
    int 10h

    mov si, gameover_msg
    mov bl, 12
    call print_centered

.wait_key:

.wait_loop:
    mov ah, 0
    int 16h
    cmp al, 13
    jne .wait_loop

    mov ah, 0
    mov al, 3
    int 10h

    jmp start

print_centered:
    push ax
    push bx
    push cx
    push dx
    push si

    xor cx, cx
.count_len:
    lodsb
    cmp al, 0
    je .len_done
    inc cx
    jmp .count_len
.len_done:
    mov ax, 80
    sub ax, cx
    shr ax, 1
    mov dl, al
    mov dh, bl
    mov bh, 0
    mov ah, 02h
    int 10h

    pop si
.print_loop2:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0E
    int 10h
    jmp .print_loop2

.done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret

draw_snake:
    push ax
    push bx
    push dx
    mov ah, 02h
    mov bh, 0
    mov dh, [y]
    mov dl, [x]
    int 10h
    mov ah, 0x0E
    mov al, '0'
    int 10h
    pop dx
    pop bx
    pop ax
    ret

erase_snake:
    push ax
    push bx
    push dx
    mov ah, 02h
    mov bh, 0
    mov dh, [y]
    mov dl, [x]
    int 10h
    mov ah, 0x0E
    mov al, ' '
    int 10h
    pop dx
    pop bx
    pop ax
    ret

delay:
    push cx
    push dx
    mov cx, 0FFFFh
.loop:
    nop
    loop .loop
    pop dx
    pop cx
    ret

section .data
msg db "Press ENTER to start the game...", 0
gameover_msg db "GAME OVER! Press ENTER to continue!", 0
x db 40
y db 12
dir db 'D'

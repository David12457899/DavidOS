ORG 0
BITS 16

_start:
    jmp short start
    nop
    times 33 db 0

start:
    jmp 0x7c0:step2

hanle_zero:
    mov ah, 0eh
    mov al, 'A'
    mov bx, 0x00
    int 0x10
    iret

hanle_one:
    mov ah, 0eh
    mov al, 'B'
    mov bx, 0x00
    int 0x10
    iret

step2:
    helloWorld db "Tomer Ha Gever!"
    cli ; Clear interrupts, so there won't be any while we change the segments
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti ; Enable interrupts

    mov word[ss:00], hanle_zero
    mov word[ss:02], 0x7c0

    mov word[ss:04], hanle_one
    mov word[ss:06], 0x7c0

    int 1

    push helloWorld
    call print

    jmp $
    jmp end

print:
    mov bp, sp
    push bp
    pusha

    mov ah, 0eh
    mov bx, 0

    mov cx, 15
    mov si, [bp + 2]

    loopy_loop:

        mov al, [si]
        int 0x10

        inc si
        loop loopy_loop

    popa
    mov sp, bp
    pop bp
    ret

end:
    times 510-($ - $$) db 01 ; 510 - (current address - beginning address)
    dw 0xAA55


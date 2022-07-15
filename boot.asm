ORG 0x7C00
BITS 16

helloWorld db "Tomer Ha Gever!"

start:
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


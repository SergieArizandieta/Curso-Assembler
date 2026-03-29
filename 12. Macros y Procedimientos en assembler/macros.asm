print macro cadena ; imprimir cadena
    mov ah, 09h
    mov dx, offset cadena
    int 21h
endm

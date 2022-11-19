.model small
.stack
.data
    msg db "Hello World Curso Assembler!!!$"
.code

    main PROC 
        ;Carga de segmento de datos a segmento de codigo
        mov ax,@data
        mov ds,ax 

        ;impresion en consola
        mov dx, offset msg
        mov ah,9
        int 21h 

        .exit
    main ENDP

end main
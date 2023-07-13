; pedir 2 caracteres con sus respectivos mensajes
; mostrar caracteres en el orden ingresados
; mostrar mensaje  de finalizacion  
; solo usar AX y DX para 

.model small
.stack
.data
    msgWelwome db 'Bienvenido al capitulo 11!',10,13,'$'
    msgChar1 db 'Ingrese el primer caracter:',10,13,'$'
    msgChar2 db 10,13,'Ingrese el segundo caracter:',10,13,'$'
    msgResultado db 10,13,'Los datos ingresados son:',10,13,'$'
    msgFin db 10,13,'FIN DEL PROGRAMA $'

.code

main proc
    mov dx,@DATA
    mov ds,dx
    xor dx,dx

    ;imprimir cadena 
    mov dx, offset msgWelwome ; dx -> el inicio de direccion de memoria donde comenzara a imprimir
    mov ah,9h ; ah -> indica que se imprimira una cadena
    int 21h ; imprimir todos los caracteres desde el inicio de la direccion hasta encontrar el caracter $


    ;imprimir cadena 
    mov dx, offset msgChar1
    mov ah,9h
    int 21h

    ;pedir caracter -> se guardara en al
    mov ah,1h
    int 21h
    push ax
    

    ;imprimir cadena 
    mov dx, offset msgChar2
    mov ah,9h
    int 21h

    ;pedir caracter -> se guardara en al
    mov ah,1h
    int 21h
    push ax


    ;imprimir cadena 
    mov dx, offset msgResultado
    mov ah,9h
    int 21h

    pop dx
    pop ax 
    
    push dx
    push ax

    pop ax

    ;imprimir caracter -> se imprime el caracter que este en dl
    mov ah,2h
    mov dl,al
    int 21h

    pop ax

    ;imprimir caracter -> se imprime el caracter que este en dl
    mov ah,2h
    mov dl,al
    int 21h

    ;imprimir cadena 
    mov dx, offset msgFin
    mov ah,9h
    int 21h


    .exit
main endp


end main
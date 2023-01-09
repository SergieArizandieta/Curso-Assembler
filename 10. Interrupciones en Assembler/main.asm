.model small
.stack
.data
    char db ?
    String db ?
.code

    main PROC  
        ;importo varibles
        mov dx, @DATA   
        mov ds , dx
        xor dx,dx   

        ;------------------------------------------------------------
        ; Pedir ingreso de char **
        ; INT 21h:

        ; AH = 1H

        ; El char ingresado se guardara en :
        ; AL
        mov ah,1h
        int 21h

        ; ;en AL esta guardado nuestro char
        ; ;pasamos al a nuestra variable
        mov char,al

        ;------------------------------------------------------------
        ; Imprir un char **
        ; INT 21h:

        ; AH = 2H
        ; DL = el char a  imprimir en la consola

        ;-- imprimir espacio--
        mov ah,2h
        mov dl,10d
        int 21h

        ;--imprimir el char pedido--
        mov ah,2h
        mov dl,char
        int 21h

        ;|||||||||||||||||||||||||||MEJORANDOLO|||||||||||||||||||||||||||||||||||||
        
        ;-- imprimir espacio--
        mov ah,2h
        mov dl,10d
        int 21h

        ;------Obtener una cadena---------
        xor si,si
        getChar:
            ;pedir un char y se guardara en AL
            mov ah,1h
            int 21h

            ;comparar si AL es un retorno de carro
            cmp al,13d
            je finGetChar

            mov String[si],al
            inc si
            jmp getChar
        finGetChar:
 
        ;si tendra el valor de la longitud del string 

        ;------------Imprimir la cadena-------------------
        xor di,di
        printChar:
            mov ah,2h 
            mov dl,String[di]
            int 21h

            inc di
            cmp di,si
            je finPrintChar
            
            jmp printChar

        finPrintChar:



        .exit
    main ENDP

end main
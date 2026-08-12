;=====================================================================
; macros.asm  -  Libreria de macros del curso
; Capitulo 13 - Arreglos en Assembler (Parte 1)
;
; Continua el archivo del capitulo 12. Se recupera printChar del
; capitulo 9 y se agrega printDigito, que es un apano temporal para
; poder VER los valores de los arreglos durante esta clase.
;=====================================================================


;---------------------------------------------------------------------
; print  ->  imprime una cadena terminada en $   (viene del capitulo 12)
;---------------------------------------------------------------------
print macro cadena
    mov ah, 09h
    mov dx, offset cadena
    int 21h
endm


;---------------------------------------------------------------------
; printChar  ->  imprime un solo caracter   (viene del capitulo 9)
;---------------------------------------------------------------------
printChar macro char
    mov ah,02h
    mov dl, char
    int 21h
endm


;---------------------------------------------------------------------
; saltoLinea  ->  retorno de carro (13) + salto de linea (10)
;---------------------------------------------------------------------
saltoLinea macro
    printChar 13d
    printChar 10d
endm


;---------------------------------------------------------------------
; printDigito valor  ->  imprime UN digito (0 a 9)
;
; Un caracter no es un numero: el caracter '7' es el byte 55, no el 7.
; Los digitos estan seguidos en la tabla ASCII ('0' vale 48), asi que
; sumandole '0' al valor obtenemos el caracter que le corresponde.
;
;     caracter = digito + '0'
;
; OJO: esto SOLO funciona del 0 al 9. Con 10 o mas hay que descomponer
; el numero en digitos, y eso necesita la pila. Lo vemos en la parte 2.
;---------------------------------------------------------------------
printDigito macro valor
    mov al, valor
    add al,'0'
    printChar al
endm

;=====================================================================
; Capitulo 13 - Arreglos en Assembler (Parte 1)
;
; Este archivo es un catalogo: cada bloque es un tema independiente.
; Se puede comentar todo menos el bloque que se quiera probar.
;
; Los valores de los arreglos son pequenos a proposito: por ahora solo
; sabemos imprimir UN digito (printDigito). Imprimir numeros de varias
; cifras es el tema de la parte 2.
;
; Compilar dentro de DOSBox:
;   mount c: c:\masm
;   c:
;   cd masm611\bin
;   ml asm\Cap13a\main.asm
;   main.exe
;=====================================================================

include macros.asm

.model small
.stack

;---------------------------------------------------------------------
; Constantes de tiempo de ensamblado.
; equ NO reserva memoria: el ensamblador sustituye el nombre por el
; numero antes de generar el .exe. Sirve para no dejar numeros magicos
; sueltos cuando se trabaja con matrices.
;---------------------------------------------------------------------
FILAS   equ 3
COLS    equ 4

.data
    ;=================================================================
    ; BLOQUE 1 - Las formas de declarar un arreglo
    ;
    ; En ensamblador NO existe el tipo "arreglo". Un arreglo es
    ; simplemente memoria contigua mas la disciplina de recorrerla
    ; bien. El nombre de la variable ES la direccion del primer
    ; elemento.
    ;=================================================================

    ;--- lista explicita de bytes: 5 elementos de 1 byte cada uno ---
    letras      db 'A','B','C','D','E'

    ;--- lista explicita de palabras: 4 elementos de 2 bytes ---
    grandes     dw 1,2,3,4

    ;--- dup: reserva 20 bytes SIN inicializar (basura) ---
    ; Esto es lo que le falto al String del capitulo 10.
    buffer      db 20 dup(?)

    ;--- dup: reserva 10 bytes puestos en cero ---
    contadores  db 10 dup(0)

    ;--- dup anidado: 3 filas de 4 columnas = 12 bytes en cero ---
    tablero     db FILAS dup(COLS dup(0))

    ;--- una cadena ES un arreglo de bytes ---
    ; estas dos lineas generan exactamente los mismos bytes:
    texto1      db 'HOLA'
    texto2      db 'H','O','L','A'

    ;--- mensajes ---
    msgTitulo   db 13,10,'=== CAP 13 - ARREGLOS (PARTE 1) ===',13,10,'$'

    msgB2       db 13,10,'--- B2: offset, type, lengthof, sizeof ---',13,10,'$'
    msgType     db 'type letras     = $'
    msgLength   db 'lengthof letras = $'
    msgSize     db 'sizeof letras   = $'
    msgTypeW    db 'type grandes    = $'
    msgLengthW  db 'lengthof grandes= $'
    msgSizeW    db 'sizeof grandes  = $'

    msgB3       db 13,10,'--- B3: recorrer arreglo de BYTES (db) ---',13,10,'$'
    msgB4       db 13,10,'--- B4: recorrer arreglo de PALABRAS (dw) ---',13,10,'$'
    msgB5       db 13,10,'--- B5: el operador ptr ---',13,10,'$'
    msgB6       db 13,10,'--- B6: matriz 2D ---',13,10,'$'

    msgFin      db 13,10,'FIN DE LA PARTE 1',13,10,'$'

.code

main proc
    ;importo el segmento de datos
    mov dx,@DATA
    mov ds,dx
    xor dx,dx

    print msgTitulo


    ;=================================================================
    ; BLOQUE 2 - Operadores de tiempo de ensamblado
    ;
    ;   offset   -> direccion donde arranca el arreglo
    ;   type     -> cuantos BYTES ocupa UN elemento
    ;   lengthof -> cuantos ELEMENTOS hay
    ;   sizeof   -> cuantos BYTES ocupa TODO   (lengthof * type)
    ;
    ; OJO: los resuelve el ENSAMBLADOR, no el procesador. Para cuando
    ; el .exe se ejecuta ya son numeros fijos incrustados en el codigo.
    ; Por eso "mov al, type letras" se convierte en "mov al,1".
    ;
    ; Nota: en el capitulo 10 se menciono "size". Ese es el operador
    ; viejo de MASM 5.1. En MASM 6 el correcto es "sizeof".
    ;
    ;SALIDA ESPERADA: 1 5 5  y luego  2 4 8
    ;=================================================================
    print msgB2

    ; OJO: MASM separa los argumentos de una macro por comas Y POR
    ; ESPACIOS, asi que "printDigito type letras" se leeria como dos
    ; argumentos. Por eso primero pasamos el valor a un registro.

    print msgType
    mov al, type letras             ; 1 byte por elemento
    printDigito al
    saltoLinea

    print msgLength
    mov al, lengthof letras         ; 5 elementos
    printDigito al
    saltoLinea

    print msgSize
    mov al, sizeof letras           ; 5 * 1 = 5 bytes
    printDigito al
    saltoLinea

    print msgTypeW
    mov al, type grandes            ; 2 bytes por elemento
    printDigito al
    saltoLinea

    print msgLengthW
    mov al, lengthof grandes        ; 4 elementos
    printDigito al
    saltoLinea

    print msgSizeW
    mov al, sizeof grandes          ; 4 * 2 = 8 bytes
    printDigito al
    saltoLinea


    ;=================================================================
    ; BLOQUE 3 - Recorrer un arreglo de BYTES
    ;
    ; for i in range(0, lengthof letras){
    ;     print( letras[i] )
    ; }
    ;
    ; Cada elemento ocupa 1 byte, asi que el indice avanza de 1 en 1.
    ;
    ;SALIDA ESPERADA: A B C D E
    ;=================================================================
    print msgB3

    xor si,si
    CICLOB3:
        cmp si, lengthof letras
        je FINB3

        printChar letras[si]        ; elemento actual
        printChar ' '

        inc si                      ; db -> avanzo 1 byte
        jmp CICLOB3

    FINB3:
    saltoLinea


    ;=================================================================
    ; BLOQUE 4 - Recorrer un arreglo de PALABRAS
    ;
    ; Cada elemento ocupa 2 bytes, asi que el indice avanza de 2 en 2.
    ; Por eso aqui comparo contra sizeof (bytes) y no contra lengthof
    ; (elementos).
    ;
    ; En el 8086 NO se puede escribir grandes[si*2]. El indice escalado
    ; existe a partir del 386, no aqui. Toca sumar a mano: add si,2
    ;
    ;SALIDA ESPERADA: 1 2 3 4
    ;=================================================================
    print msgB4

    xor si,si
    CICLOB4:
        cmp si, sizeof grandes      ; comparo BYTES, no elementos
        je FINB4

        mov ax, grandes[si]
        printDigito al

        printChar ' '

        add si,2                    ; dw -> avanzo 2 bytes
        jmp CICLOB4

    FINB4:
    saltoLinea

    ;--- ERROR A PROPOSITO -------------------------------------------
    ; Descomenta este bloque y compara la salida con la de arriba.
    ;
    ; Con inc si el indice cae a la mitad de cada elemento: se lee la
    ; mitad alta de un numero pegada a la mitad baja del siguiente.
    ; Como nuestros valores son chicos, la parte alta es cero y se ven
    ; aparecer ceros intercalados:
    ;
    ;SALIDA DEL ERROR: 1 0 2 0 3 0 4 0
    ;
    ; xor si,si
    ; CICLOMAL:
    ;     cmp si, sizeof grandes
    ;     je FINMAL
    ;     mov ax, grandes[si]
    ;     printDigito al
    ;     printChar ' '
    ;     inc si
    ;     jmp CICLOMAL
    ; FINMAL:
    ; saltoLinea
    ;-----------------------------------------------------------------


    ;=================================================================
    ; BLOQUE 5 - El operador ptr
    ;
    ; Cuando el destino es solo una direccion entre corchetes, MASM no
    ; tiene forma de saber si debe escribir 1 byte o 2:
    ;
    ;   mov [bx],7          ; <- NO ensambla, tamano ambiguo
    ;   mov byte ptr [bx],7 ; escribe 1 byte
    ;   mov word ptr [bx],7 ; escribe 2 bytes
    ;
    ; Recordatorio: entre corchetes solo pueden ir BX, BP, SI y DI.
    ; AX, CX y DX no sirven como indice en el 8086.
    ;
    ;SALIDA ESPERADA: 7 7 7 0 0 0 0 0 0 0
    ;=================================================================
    print msgB5

    mov bx, offset contadores       ; bx apunta al primer elemento

    mov byte ptr [bx],7d            ; contadores[0] = 7
    inc bx
    mov byte ptr [bx],7d            ; contadores[1] = 7
    inc bx
    mov byte ptr [bx],7d            ; contadores[2] = 7

    ;recorro los 10 para ver que los otros 7 siguen en cero
    xor si,si
    CICLOB5:
        cmp si, lengthof contadores
        je FINB5

        printDigito contadores[si]
        printChar ' '

        inc si
        jmp CICLOB5

    FINB5:
    saltoLinea


    ;=================================================================
    ; BLOQUE 6 - Matriz 2D
    ;
    ; La memoria es LINEAL. Una matriz no existe en el hardware: la
    ; inventamos guardando las filas una detras de otra (row-major) y
    ; calculando la posicion con una formula:
    ;
    ;       indice = fila * COLS + columna
    ;
    ; tablero db FILAS dup(COLS dup(0))  -> 3 filas de 4 columnas
    ;
    ; En memoria:
    ;   [f0c0][f0c1][f0c2][f0c3][f1c0][f1c1]...[f2c3]
    ;
    ; Llenamos cada celda con 'A' + indice para que se vea de un
    ; vistazo como quedan las filas una detras de otra.
    ;
    ; Esta formula es la misma que sostiene el tablero del Tetris del
    ; capitulo 18.
    ;
    ;SALIDA ESPERADA:
    ;   A B C D
    ;   E F G H
    ;   I J K L
    ;=================================================================
    print msgB6

    ;--- llenar: tablero[fila][columna] = 'A' + indice ---
    xor si,si                       ; si = fila
    CICLOFILA:
        cmp si, FILAS
        je FINLLENAR

        xor di,di                   ; di = columna
        CICLOCOL:
            cmp di, COLS
            je FINCOL

            ;indice = fila * COLS + columna
            mov ax,si
            mov bx, COLS
            mul bx                  ; DX:AX = AX * BX
            add ax,di
            mov bx,ax               ; bx = indice lineal

            add al,'A'              ; valor = 'A' + indice
            mov tablero[bx], al

            inc di
            jmp CICLOCOL

        FINCOL:
        inc si
        jmp CICLOFILA

    FINLLENAR:

    ;--- imprimir fila por fila ---
    xor si,si
    CICLOFILA2:
        cmp si, FILAS
        je FINIMPRIMIR

        xor di,di
        CICLOCOL2:
            cmp di, COLS
            je FINCOL2

            ;misma formula para llegar al elemento
            mov ax,si
            mov bx, COLS
            mul bx
            add ax,di
            mov bx,ax

            printChar tablero[bx]
            printChar ' '

            inc di
            jmp CICLOCOL2

        FINCOL2:
        saltoLinea
        inc si
        jmp CICLOFILA2

    FINIMPRIMIR:


    print msgFin
    .exit
main endp

end main

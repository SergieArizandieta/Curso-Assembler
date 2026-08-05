# Interrupciones en Assembler

- **Link:** https://youtu.be/MJOik3Kr8NU
- **Video #:** 11
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/10.%20Interrupciones%20en%20Assembler
  - `main.asm`

## Tema general
Concepto de interrupciones en ensamblador, con foco en las interrupciones por software (`INT`), usadas para gestionar operaciones de entrada/salida de caracteres y cadenas de texto mediante registros.

## Qué se explicó / enseñó
- **Interrupción**: situación especial que suspende el flujo normal del programa para que el sistema realice una acción específica mediante un manejador (ISR).
- **Tipos**: por Hardware y por Software. El video se enfoca en las de software (`INT`) para E/S.
- **Estructura**: mnemónico `INT` seguido de un número en hexadecimal (0-255).
- **Requerimientos**: cada interrupción exige valores específicos en ciertos registros (ej. AH, AL, DL) para funcionar.
- **Interrupción 21H**: `AH = 1` lee un carácter (guardado en AL); `AH = 2` imprime un carácter (tomado de DL).
- **Operadores `size` y `offset`**: `size` devuelve el número de bytes de una variable; `offset` devuelve la dirección de memoria donde inicia una expresión.

## Qué se hizo (paso a paso)

```asm
.model small
.stack
.data
    char db ?
    String db ?
.code

    main PROC
        ;importo variables
        mov dx, @DATA
        mov ds , dx
        xor dx,dx

        ;------------------------------------------------------------
        ; Pedir ingreso de char
        ; INT 21h: AH = 1H → el char ingresado se guarda en AL
        mov ah,1h
        int 21h

        ;en AL esta guardado nuestro char, lo pasamos a la variable
        mov char,al

        ;------------------------------------------------------------
        ; Imprimir un char
        ; INT 21h: AH = 2H, DL = el char a imprimir en consola

        ;-- imprimir salto de linea--
        mov ah,2h
        mov dl,10d
        int 21h

        ;--imprimir el char pedido--
        mov ah,2h
        mov dl,char
        int 21h

        ;|||||||||||||||||||||||||||MEJORANDOLO|||||||||||||||||||||||||||||||||||||

        ;-- imprimir salto de linea--
        mov ah,2h
        mov dl,10d
        int 21h

        ;------Obtener una cadena---------
        xor si,si
        getChar:
            ;pedir un char, se guarda en AL
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
```

1. **Primer ejercicio**: pedir un carácter (`MOV AH,1` + `INT 21H`) y luego imprimirlo (`MOV AH,2` + `INT 21H`), guardándolo antes en la variable `char`.
2. **Manejo de saltos de línea**: para imprimir un salto de línea, se carga el valor 10 (ASCII de nueva línea) en DL y se ejecuta `INT 21H`.
3. **Segundo ejercicio (cadenas)**: se declara `String db ?` y se crea un bucle (`getChar`) que lee caracteres hasta detectar un retorno de carro (13 decimal / 0DH hex).
   - Se compara el carácter leído en AL con `13d`. Si son iguales, se salta fuera del bucle (`je finGetChar`).
   - Si no, se guarda en el arreglo (`String[si]`), se incrementa el contador SI, y se repite.
4. **Impresión de cadena**: bucle similar (`printChar`) que recorre el arreglo incrementando el índice DI y comparándolo contra el contador de longitud total (SI) para saber cuándo terminar.
5. Se discutió como alternativa la interrupción `AH=09H`, que imprime hasta encontrar un símbolo `$`, más eficiente que recorrer manualmente el arreglo.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (Assembler)
- MASM (ensamblador/linker)
- Páginas de apoyo: helppc.netcore2k.net y sistel.xp3.biz

## Problemas o errores
- **Problema**: al imprimir el carácter ingresado, aparecía junto al prompt o pegado a la línea siguiente.
  - **Resolución**: se introdujo la impresión del ASCII 10 (salto de línea) entre la lectura y la impresión.
- **Problema**: riesgo de imprimir "basura" en memoria al recorrer el arreglo de la cadena.
  - **Resolución**: se ajustó la lógica de comparación del índice para no exceder el tamaño real del String (o usar el marcador de fin `$`).

## Conclusiones / cierre
Se logró implementar lectura y escritura eficiente de cadenas de texto usando interrupciones del DOS. Se enfatizó que el manejo de memoria (arreglos) debe ser cuidadoso para evitar lecturas fuera de rango. Queda pendiente profundizar en otras interrupciones del sistema (tiempo, fecha, video) y el uso de la instrucción `CALL`.

## Timestamps clave
- 0:01 — Teoría de las interrupciones
- 3:56 — Interrupción 21H para imprimir y leer
- 7:07 — Operadores size y offset
- 8:04 — Propuesta de la práctica
- 9:05 — Primera parte de la práctica
- 16:25 — Segunda parte de la práctica (creación de arreglo de cadena)
- 20:38 — Comparación con retorno de carro (13D)
- 28:13 — Impresión de cadena mediante bucle
- 37:20 — Página de referencia de interrupciones
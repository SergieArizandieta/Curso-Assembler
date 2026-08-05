# Variables en Assembler

- **Link:** https://youtu.be/qHlEhYCnbc0
- **Video #:** 8
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/7.%20Variables%20de%20Aseembler
  - `main.asm`

## Tema general
Fundamentos de las variables en ensamblador: tipos de datos (DB, DW, DD) y su relación con los registros de 8, 16 y 32 bits, además de ejercicios prácticos de operaciones aritméticas e introducción a los arreglos.

## Qué se explicó / enseñó
- **Tipos de datos**: `DB` (Data Byte, 8 bits), `DW` (Data Word, 16 bits), `DD` (Data Double, 32 bits).
- **Relación registro-variable**: una variable debe ser del mismo tamaño que el registro con el que interactúa, o genera error de compilación.
- **Segmentos de memoria**: definición de variables bajo `.data`, e importación del segmento con `@data`, `AX` y `DS`.
- **Caracteres ASCII**: un carácter imprimible ocupa 8 bits; dos caracteres juntos ocupan 16 bits.
- **Arreglos**: introducción a cómo las variables se almacenan en memoria y pueden tratarse como arreglos al definirse de forma sucesiva o mediante asignaciones directas.

## Qué se hizo (paso a paso)
Código base (`main.asm`), con errores intencionales comentados para ilustrar los límites de cada tipo:

```asm
.model small
.stack
.data
    ;Err1 db 256d
    ;Err2 dw 65536d

    DataByte db 200d
    DataWord dw 60000d
    DataDouble dd 90000d


    ;variables ------ parte 2
    var1 db "!"
    var2 dw "+!"

    var3 db "+!"
    var4 dw "+!+"

    var5 db "+","!","+"
    var6 dw "+","!","+"

    var7 db 200d,200d,200d,200d,200d,200d
    var8 dw 60000d,60000d,60000d,60000d,60000d

.code

    main PROC
        ;Importacion a segmento
        mov ax,@data
        mov ds,ax
        xor ax,ax

        ;mov ax,DataByte ;Error

        ;AL = DB + AL
        ;mov al,55d
        ;add al,DataByte

        ;DW = DW - CX
        ;mov cx,50000d
        ;sub DataWord,cx

        ;EAX = DD / EBX    <---- Emu 8086 = microprocesador de 16 bits
        ;mov eax,DataDouble
        ;mov EBX,10000d
        ;div EBX

        ;AX =  DW / BX
        ;mov ax,DataWord
        ;mov bx,2d
        ;div bx

        ;AL = DB * BL
        ;mov al,DataByte
        ;mov bl,2d
        ;mul bl

        ;--- << 2da parte >> ---
        ;Diferencias entre registros y variables

        ;1 caracter = 8 bits
        ;2 caracteres = 16 bits

        ;mov al,"+"
        ;mov al,"+!" ;Error

        ;mov ax,"+!"
        ;mov ax,"!+!" ;Error

        ;al,ah,bl,bh ... = DB
        ;AX,BX,CX,DX ... = DW

        .exit
    main ENDP

end main
```

1. **Configuración inicial** en EMU8086.
2. **Creación de variables**: `DataByte db 200d`, `DataWord dw 60000d`, `DataDoble dd 90000d`.
3. **Importación**: `mov ax, @data` / `mov ds, ax`.
4. **Ejercicios aritméticos**:
   - Suma: `AL = 55` + `DataByte (200)` = 255.
   - Resta: `sub DataWord, cx` con CX = 50000.
   - División/multiplicación: mover el valor de la variable a un registro (ej. AX) y operar con otro registro (BX).
5. **Pruebas con caracteres**: caracteres `'+'` y `'!'` asignados a registros y variables, mostrando cómo se almacenan en memoria (1 carácter = 8 bits, 2 caracteres = 16 bits).

## Herramientas / tecnologías mencionadas
- Lenguaje Assembler (Ensamblador)
- Emulador EMU8086
- Tabla de códigos ASCII

## Problemas o errores
- **Desbordamiento (Overflow)**: guardar un valor mayor a 8 bits en una variable `DB` (ej. `Err1 db 256d`) lanza error "over 8 bits". Se resuelve ajustando el tamaño de la variable o el valor asignado.
- **Incongruencia de tamaño**: sumar una variable de 8 bits con un registro de 16 bits causa error (`mov ax,DataByte` comentado como error). Se resuelve igualando el tamaño de los operandos.
- **Limitación del procesador**: usar registros de 32 bits (`EAX`, `EBX`) en Emu8086 da error, porque ese procesador (8086) es de 16 bits.
- **Error con caracteres**: asignar más caracteres de los permitidos (ej. `mov al,"+!"` con 2 caracteres a un registro de 8 bits) genera error o valores nulos en memoria.

## Conclusiones / cierre
Las variables actúan como registros extendidos; su manejo correcto depende de la alineación de bits. Próximo tema: condicionales, saltos y bucles.

## Timestamps clave
- 0:15 — Tipos de datos (DB, DW, DD)
- 2:36 — Parte práctica en EMU8086
- 4:39 — Importación de variables al segmento de datos
- 7:02 — Ejemplo de suma con variables
- 11:21 — Limitaciones de registros de 32 bits en procesadores de 16 bits
- 16:05 — Diferencias entre registros, variables y uso de caracteres ASCII
- 22:37 — Introducción a las variables como arreglos
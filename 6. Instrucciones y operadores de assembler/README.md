# Instrucciones y Operadores de Assembler

- **Link:** https://youtu.be/jchzW9d2FBI
- **Video #:** 7
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/6.%20Instrucciones%20y%20operadores%20de%20assembler
  - `main.asm`

## Tema general
Instrucciones y operadores fundamentales del ensamblador: operaciones aritméticas, lógicas y manejo básico de datos mediante registros y memoria.

## Qué se explicó / enseñó
- **MOV**: asignación que transfiere datos del operando derecho al izquierdo. Para registros, memoria (stack/arreglos) e inmediatos, el tamaño de bits debe coincidir.
- **Operador inmediato (IMM)**: constante numérica. Si el inmediato es de 8 bits y se mueve a un registro de 16 bits, el ensamblador coloca el valor en la parte baja y ceros en la parte alta automáticamente.
- **Operaciones aritméticas**: `ADD` (suma), `SUB` (resta), `MUL` (multiplicación), `DIV` (división).
- **Operaciones lógicas**: tablas de verdad de `AND`, `OR`, `NOT` y `XOR` (OR exclusivo).
- **Naturaleza destructiva**: muchas instrucciones reemplazan el valor original del registro destino.

## Qué se hizo (paso a paso)
Código base (`main.asm`) con cada operación comentada para practicar descomentando por partes:

```asm
.model small
.stack
.data
.code

    main PROC
        ;Operadores aritmeticos

        ;Suma(ADD)------------------
        ;1000 + 999 = 1999
        ;mov ax,1000d
        ;mov bx,999d
        ;add ax,bx
        ;ax = ax + bx

        ;Resta(SUB)------------------
        ;300 - 255  = 45
        ;mov bx,300d
        ;mov ax,255d
        ;sub bx,ax
        ;bx = bx - ax

        ;multiplicacion(MUL)------------------
        ;11 * 255  = 2805
        ;mov ax,255d
        ;mov bx,11d
        ;mul bx
        ;ax = ax * bx

        ;Division(DIV)------------------
        ;1000 / 100  = 10
        ;mov ax,1000d
        ;mov bx,100d
        ;div bx
        ;ax = ax / bx

        ;Operadores logicos

        ;AND------------------
        ;214 and 91
        ;11010110
        ;01011011 AND
        ;01010010 = 82
        ;mov ax,11010110b
        ;mov bx,01011011b
        ;and ax,bx

        ;OR------------------
        ;214 OR 91
        ;11010110
        ;01011011 OR
        ;11011111 = 223
        ;mov ax,11010110b
        ;or ax,01011011b

        ;NOT------------------
        ;NOT 214
        ;11010110
        ;NOT
        ;00101001 = 41
        ;mov ax,11010110b
        ;not al

        ;XOR------------------
        ;214 XOR 91
        ;11010110
        ;01011011 XOR
        ;10001101 = 141
        ;mov ax,11010110b
        ;xor ax,01011011b

        ;Xor------------------
        ;xor ax,ax

        .exit
    main ENDP

end
```

1. **Suma (ADD)**: `mov ax,1000d` / `mov bx,999d` / `add ax,bx` → 1000 + 999 = 1999. Uso de la `d` para denotar decimal.
2. **Resta (SUB)**: `mov bx,300d` / `mov ax,255d` / `sub bx,ax` → 300 - 255 = 45.
3. **Multiplicación (MUL)**: `mov ax,255d` / `mov bx,11d` / `mul bx` → multiplica AX por el operando y guarda el resultado en AX (255 × 11 = 2805).
4. **División (DIV)**: `mov ax,1000d` / `mov bx,100d` / `div bx` → AX (numerador) ÷ BX, cociente guardado en AX (1000 / 100 = 10).
5. **Lógica bit a bit** (con 214 = `11010110` y 91 = `01011011`):
   - `AND`: 214 and 91 = 82 (`01010010`)
   - `OR`: 214 or 91 = 223 (`11011111`)
   - `NOT`: NOT 214 = 41 (`00101001`) — se usó `NOT AL` en vez de `NOT AX` para no invertir los bits altos (que estaban en cero).
   - `XOR`: 214 xor 91 = 141 (`10001101`)
6. **Truco de reinicio**: `XOR AX, AX` para limpiar un registro de forma eficiente.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (Assembler)
- Emulador 8086 (entorno de práctica, mencionado indirectamente)

## Problemas o errores
No hubo errores técnicos de compilación/ejecución, pero se advirtió sobre el error lógico de aplicar `NOT` a un registro de 16 bits cuando el dato relevante ocupa solo 8 bits (AL) — corrompería el valor total del registro.

## Conclusiones / cierre
Dominar estas instrucciones básicas permite resolver una vasta cantidad de problemas en ensamblador. Próximo tema: operadores relacionales.

## Timestamps clave
- 0:56 — Operador MOV
- 6:43 — Operadores aritméticos (ADD, SUB, MUL, DIV)
- 19:31 — Operadores lógicos (AND, OR, NOT, XOR)
- 29:56 — Estrategia para reiniciar registros con XOR
# Sentencias Cíclicas y de Control en Assembler

- **Link:** https://youtu.be/SLBPUiRc1b4
- **Video #:** 10
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/9.%20Sentencias%20Cliclicas%20y%20de%20Control%20en%20Assembler
  - `main.asm`

## Tema general
Implementación de estructuras de control (`if`, `if-or`, `if-and`) y ciclos (`for`, `while`, `while-break`, `while-continue-break`) en ensamblador x86, usando saltos condicionales y etiquetas.

## Qué se explicó / enseñó
- **Modelo base del programa**: configuración de segmentos de datos y código; importancia de importar variables con `@Data` y `DS`.
- **Macros de impresión**: se introdujo una macro simple (`printChar`) para imprimir caracteres mediante interrupciones del sistema (detalles de la interrupción se dejan para otro capítulo).
- **If-Else**: bifurcación del flujo mediante `CMP` y saltos condicionales (`JZ`, `JNZ`, `JMP`). Uso de etiquetas (L1, L2, L3) para saltar bloques no deseados y evitar que el bloque falso se ejecute tras el verdadero.
- **Lógica booleana OR/AND (cortocircuito)**:
  - **OR**: si una condición se cumple, se salta al código principal; si falla, se da una "segunda oportunidad" evaluando la siguiente condición.
  - **AND**: se evalúa primero la versión "falsa" para salir inmediatamente si no cumple, optimizando el flujo.
- **Ciclos For/While**:
  - `For`: se implementa comparando un índice (registro SI) contra un límite y usando un salto para volver al inicio.
  - `While`: usa una condición lógica al principio y una etiqueta de retorno.
  - `break`: salto a una etiqueta fuera del bloque del ciclo.
  - `continue`: el puntero de ejecución regresa directamente al inicio del ciclo.

## Qué se hizo (paso a paso)

Macros usadas para imprimir y para marcar visualmente cada sección de salida:
```asm
printChar macro char
    mov ah,02h
    mov dl, char
    int 21h
endm

printDiferencia macro char
    printChar 10
    printChar '~'
    printChar '~'
    printChar '~'
    printChar '~'
    printChar '~'
    printChar '~'
    printChar 10
endm
```

Declaración de condiciones booleanas:
```asm
.data
    COND1 db 1b
    COND2 db 1b
    COND3 db 0b
```

### 1. IF normal (recapitulación)
```asm
; if(COND1){ print('a') } else { print('b') }
cmp COND1,1b
je L1
jmp L2

L1:
    printChar 'a'
    jmp L3
L2:
    printChar 'b'
L3:
```

### 2. IF - OR
```asm
; if( COND1 OR COND2 ){ print('a') } else { print('b') }
cmp COND1,1b
je Z1

cmp COND2,1b
je Z1
jmp Z2

Z1:
    printChar 'a'
    jmp Z3
Z2:
    printChar 'b'
Z3:
```

### 3. IF - AND (versión optimizada)
```asm
; if( COND1 AND COND2 ){ print('a') } else { print('b') }
cmp COND1,1b
jne P1

cmp COND2,1b
jne P1

printChar 'a'
jmp P2

P1:
    printChar 'b'
P2:
```
(En el código también quedó comentada una primera versión menos optimizada usando etiquetas true/false separadas.)

### 4. FOR (0..6)
```asm
; for n in range(0,6){ print('a') }  → salida esperada: aaaaa
xor si,si
CFOR:
  cmp si,5d
  je SALIRFOR

  printChar 'a'
  inc si
  jmp CFOR

SALIRFOR:
```

### 5. WHILE (condición)
```asm
; COND1 = true; contador = 0
; while(COND1){ print('b'); if(contador==5) COND1=false; contador++ }
; salida esperada: bbbbbb
mov COND1,1b
xor si,si

CWHILE:
    cmp COND1,1b
    jne EXITWHILE

    printChar 'b'

    cmp si,5d
    je SIES5
    jmp NOES5

    SIES5:
        mov COND1,0b
    NOES5:

    inc si
    jmp CWHILE

EXITWHILE:
```

### 6. WHILE(true) - BREAK
```asm
; contador=0; while(true){ print('z'); if(contador==4) break; contador++ }
; salida esperada: zzzzz
xor si,si
CWHILE2:
    printChar 'z'

    cmp si,4d
    je SIES4
    jmp NOES4

    SIES4:
        jmp EXITWHILE2
    NOES4:

    inc si
    jmp CWHILE2

EXITWHILE2:
```

### 7. WHILE(true) - CONTINUE / BREAK
```asm
; contador=0
; while(true){
;   contador++
;   if(contador==3){ print('a'); continue }
;   print('z')
;   if(contador==4){ break }
; }
; salida esperada: zzaz
xor si,si
CWHILE3:
    inc si

    cmp si,3d
    je SIES3
    jmp NOES3

    SIES3:
        printChar 'a'
        jmp CWHILE3
    NOES3:

    printChar 'z'

    cmp si,4d
    je SIESS4
    jmp NOESS4

    SIESS4:
        jmp EXITWHILE4
    NOESS4:

    jmp CWHILE3

EXITWHILE4:
```

## Herramientas / tecnologías mencionadas
- Ensamblador (Assembler x86)
- Emu8086
- Visual Studio Code (se explicó por qué a partir de este video se usará como editor principal)
- DOSBox (emulación y compilación)
- ML (Microsoft Macro Assembler)

## Problemas o errores
- **Error de compilación**: al llamar a una macro `print` definida en un archivo no incluido o en conflicto; se resolvió revisando la estructura del proyecto en Visual Studio Code.
- **Bucle infinito**: en la construcción del `While`, el código original olvidó incrementar el contador (`INC`), causando que el programa se quedara atrapado; se resolvió añadiendo la instrucción de incremento dentro del cuerpo del ciclo.

## Conclusiones / cierre
Se dominó la lógica de control avanzada mediante saltos y etiquetas, mostrando que en ensamblador no existen estructuras predefinidas como en lenguajes de alto nivel — todo se construye gestionando el flujo del procesador. Próximo capítulo: Interrupciones.

## Timestamps clave
- 1:03 — IF normal (recapitulación del capítulo pasado)
- 9:17 — ¿Por qué ahora usaremos Visual Studio Code?
- 11:29 — IF - Or
- 17:33 — IF - And
- 24:56 — For
- 28:09 — While (condición)
- 34:41 — While (true) - Break
- 40:40 — While (true) - Break - Continue
- 48:41 — Próximo capítulo
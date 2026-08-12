# Arreglos en Assembler (Parte 1)

- **Link:** _(pendiente)_
- **Video #:** 14
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/13.%20Arreglos%20en%20Assembler%20Parte%201
  - `main.asm`, `macros.asm`
  - `Teoria.md` (documento de estudio), `Guion.md` (guion de la clase), `Presentacion.pptx`
- **Continúa en:** [Arreglos en Assembler (Parte 2)](../13.%20Arreglos%20en%20Assembler%20Parte%202/README.md)

## Tema general
Arreglos en ensamblador x86: cómo se reserva memoria contigua, qué operadores da MASM para consultarla, qué registros pueden usarse como índice en el 8086, cómo se recorre un arreglo según el tamaño de sus elementos y cómo se construye una matriz sobre una memoria que en realidad es lineal.

Es la primera de dos partes. La conversión entre caracteres y números —y la corrección completa de `MUL` y `DIV`— quedan para la Parte 2.

## Qué se explicó / enseñó
- **Qué es un arreglo**: no existe como tipo de dato. Es memoria contigua más la disciplina de recorrerla bien. El nombre de la variable es la dirección del primer elemento, y todo se deriva de `dirección = base + (i × tamaño)`.
- **Declaración**: lista explícita (`db 'A','B','C'`), operador `DUP` (`db 20 dup(?)`), diferencia entre `?` (sin inicializar) y `0` (en cero), `DUP` anidado para matrices, y `EQU` para constantes de tiempo de ensamblado.
- **Una cadena es un arreglo**: `db 'HOLA'` y `db 'H','O','L','A'` generan exactamente los mismos bytes.
- **`printDigito`**: macro auxiliar de tres líneas para poder mostrar valores en pantalla durante la clase. Aprovecha que los dígitos son consecutivos en ASCII (`carácter = dígito + '0'`). Solo funciona del 0 al 9; esa limitación es el gancho de la Parte 2.
- **Operadores de MASM**: `offset` (dirección de inicio), `type` (bytes por elemento), `lengthof` (número de elementos) y `sizeof` (bytes totales). Los resuelve el ensamblador, no el procesador: en el `.exe` ya son constantes fijas. Se aclaró que `size`, mencionado en el capítulo 10, es el operador antiguo de MASM 5.1 y que el correcto en MASM 6 es `sizeof`.
- **Direccionamiento en el 8086**: los corchetes significan "el contenido de la dirección". Solo `BX`, `BP`, `SI` y `DI` pueden ir dentro de corchetes; `AX`, `CX` y `DX` no. `BP` usa `SS` por defecto, el resto usa `DS`. Combinaciones válidas (base + índice + desplazamiento) e inválidas (`[BX+BP]`, `[SI+DI]`).
- **No hay índice escalado**: `arr[si*2]` es del 386 en adelante. En el 8086 hay que avanzar a mano con `add si,2`.
- **Recorrido según el tipo**: `db` avanza con `inc si`, `dw` con `add si,2`, `dd` con `add si,4`. Con `dw` el bucle se corta comparando contra `sizeof` (bytes) y no contra `lengthof` (elementos).
- **Operador `ptr`**: `mov [bx],7` es ambiguo porque MASM no sabe si escribir uno o dos bytes; se resuelve con `byte ptr` o `word ptr`.
- **Matrices 2D**: la memoria es lineal, la matriz es una convención. Almacenamiento por filas (row-major) y la fórmula `índice = fila × ANCHO + columna`, donde `ANCHO` es el número de columnas.

## Qué se hizo (paso a paso)

El capítulo arranca corrigiendo un error real que quedó en el capítulo 10: `String db ?` reserva un solo byte y el bucle escribía en `String[si]` sin límite.

**macros.asm** (continúa el archivo del capítulo 12):

```asm
;print viene del capitulo 12
print macro cadena
    mov ah, 09h
    mov dx, offset cadena
    int 21h
endm

;printChar viene del capitulo 9
printChar macro char
    mov ah,02h
    mov dl, char
    int 21h
endm

saltoLinea macro
    printChar 13d
    printChar 10d
endm

;imprime UN digito (0 a 9): caracter = digito + '0'
printDigito macro valor
    mov al, valor
    add al,'0'
    printChar al
endm
```

**main.asm** — catálogo de seis bloques, cada uno con su pseudocódigo y su salida esperada:

1. **Declaración**: `letras db 'A','B','C','D','E'` y `grandes dw 1,2,3,4` como listas explícitas; `buffer db 20 dup(?)` y `contadores db 10 dup(0)`; `tablero db FILAS dup(COLS dup(0))` con `FILAS equ 3` y `COLS equ 4`; y las dos formas equivalentes de declarar la cadena `HOLA`.
2. **Operadores**: se imprimen `type`, `lengthof` y `sizeof` de un arreglo `db` (1, 5, 5) y de uno `dw` (2, 4, 8). Como MASM separa los argumentos de macro por espacios además de por comas, el valor se pasa antes a un registro (`mov al, type letras` / `printDigito al`).
3. **Recorrido de `db`**: bucle con `inc si` cortando contra `lengthof`. Salida: `A B C D E`.
4. **Recorrido de `dw`**: bucle con `add si,2` cortando contra `sizeof`. Salida: `1 2 3 4`. Debajo queda comentado el bloque `CICLOMAL`, que usa `inc si` sobre el mismo arreglo para demostrar el error en pantalla.
5. **`ptr`**: `mov byte ptr [bx],7d` sobre los tres primeros elementos de `contadores` y volcado de los diez para comprobar que el resto sigue en cero. Salida: `7 7 7 0 0 0 0 0 0 0`.
6. **Matriz 2D**: se llena `tablero[fila][columna] = 'A' + índice` usando `índice = fila × COLS + columna` y se imprime fila por fila. Salida:
   ```
   A B C D
   E F G H
   I J K L
   ```
   Se llenó con letras consecutivas a propósito: así se ve de un vistazo que las filas están guardadas una detrás de otra en memoria.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (x86, Intel 8086)
- MASM 6.11 (Microsoft Macro Assembler)
- DOSBox
- Emu8086
- Visual Studio Code
- Interrupciones del DOS (`INT 21h`, funciones `02h` y `09h`)

## Problemas o errores
- **Escritura fuera de un arreglo (capítulo 10)**: `String db ?` reserva un único byte, pero el bucle escribía en `String[si]` con el índice creciendo sin límite. No dio error porque DOS corre en modo real y el segmento de datos tiene 64 KB libres detrás, así que el programa escribía memoria sin dueño. Se corrigió reservando el espacio con `DUP`, y se mostró que bastaba declarar una variable después de `String` para que se corrompiera sola.
- **Recorrer un arreglo `dw` con `inc si`**: el índice cae a la mitad de cada elemento y se lee la mitad alta de un número pegada a la mitad baja del siguiente. Con los valores `1,2,3,4` la salida fue `1 0 2 0 3 0 4 0`: los ceros intercalados son los bytes altos de cada palabra asomando. No lanza ningún error. Se resolvió avanzando con `add si,2` y comparando contra `sizeof` en vez de `lengthof`.
- **Argumentos de macro separados por espacios**: `printDigito type letras` no ensambla, porque MASM separa los argumentos por comas **y también por espacios**, y lee `type` y `letras` como dos argumentos distintos. Se resolvió pasando el valor a un registro antes de invocar la macro.
- **`printDigito` con valores mayores a 9**: `12 + '0'` da 60, que es el carácter `<`. No da error, solo imprime un símbolo raro. Es la limitación que motiva la Parte 2.
- **Registros no válidos entre corchetes**: intentar `mov al,[cx]` no ensambla. En el 8086 solo `BX`, `BP`, `SI` y `DI` sirven como base o índice.
- **`mov [bx],7` sin `ptr`**: MASM no puede deducir si son uno o dos bytes y rechaza la instrucción. Se resolvió con `byte ptr`.

## Conclusiones / cierre
Los arreglos son el primer punto del curso donde el programador queda solo: el procesador no verifica límites, no avisa de un desbordamiento y devuelve basura con toda la apariencia de un dato correcto. La fórmula `base + i × tamaño` y su extensión a dos dimensiones (`fila × ANCHO + columna`) son la base del tablero del Tetris que se construirá en el capítulo 18. Antes de cerrar se adelantó que lo dicho en los capítulos 6 y 7 sobre `MUL` y `DIV` está incompleto, y se recomendó anteponer `xor dx,dx` a cualquier `div` hasta que se explique bien. Próxima clase: la Parte 2, donde se construyen `readInt` y `printInt` para poder trabajar con números y no solo con caracteres.

## Timestamps clave
- 0:00 — _(pendiente)_ Introducción, repaso del capítulo 12 y aviso de que son dos partes
- 0:00 — _(pendiente)_ El error del capítulo 10: `String db ?`
- 0:00 — _(pendiente)_ Qué es un arreglo en ensamblador
- 0:00 — _(pendiente)_ Declaración, `DUP`, `?` frente a `0` y `EQU`
- 0:00 — _(pendiente)_ Una cadena es un arreglo de bytes
- 0:00 — _(pendiente)_ La macro `printDigito` y su límite
- 0:00 — _(pendiente)_ `offset`, `type`, `lengthof` y `sizeof`
- 0:00 — _(pendiente)_ Direccionamiento: qué registros van entre corchetes
- 0:00 — _(pendiente)_ Por qué no existe `[si*2]` en el 8086
- 0:00 — _(pendiente)_ Recorrer arreglos de `db` y de `dw`
- 0:00 — _(pendiente)_ El error en vivo: `inc si` sobre un arreglo `dw`
- 0:00 — _(pendiente)_ El operador `ptr`
- 0:00 — _(pendiente)_ Matrices 2D y la fórmula del índice
- 0:00 — _(pendiente)_ Adelanto de `MUL`/`DIV` y cierre

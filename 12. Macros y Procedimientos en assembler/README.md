# Macros y Procedimientos en Assembler

- **Link:** https://youtu.be/8Az8PVD0vJM
- **Video #:** 13
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/12.%20Macros%20y%20Procedimientos%20en%20assembler
  - `main.asm`, `macros.asm`

## Tema general
Diferencia conceptual y técnica entre procedimientos y macros en ensamblador x86: cómo funcionan internamente y cuándo usar cada uno para optimizar el código, con demostración práctica de ambos.

## Qué se explicó / enseñó
- **Procedimientos**: subrutinas que agrupan instrucciones para tareas específicas. Usan `CALL` para saltar a la dirección del procedimiento y `RET` para regresar. Internamente, `CALL` guarda la dirección de retorno en el stack; `RET` la extrae para volver al flujo principal.
- **Estructura de un procedimiento**: etiquetas `PROC` (inicio) y `ENDP` (final); importancia de incluir `RET` dentro del bloque.
- **Macros**: a diferencia de los procedimientos, una macro inserta el bloque de instrucciones directamente en el lugar donde se llama, durante la compilación. No requiere `CALL` ni manejo de pila para el salto.
- **Diferencias de diseño**: macros preferibles para tareas pequeñas y repetitivas (ej. imprimir texto); procedimientos ideales para organizar el flujo lógico de un programa complejo.
- **Parámetros y etiquetas locales**: las macros aceptan parámetros (variables) y pueden usar `LOCAL` para evitar conflictos de nombres en etiquetas internas cuando se insertan varias veces en el código.

## Qué se hizo (paso a paso)

**macros.asm**:
```asm
print macro cadena ; imprimir cadena
    mov ah, 09h
    mov dx, offset cadena
    int 21h
endm
```

**main.asm**:
```asm
include macros.asm
.model small
.stack
.data
    msgWelcome db 'Bienvenido al capitulo 12',13,10,'$'
    msg1 db 'Este es el primer mensaje',13,10,'$'
    msg2 db 'Este es el segundo mensaje',13,10,'$'
    msg3 db 'Este es el tercer mensaje',13,10,'$'
    msg4 db 'Este es el cuarto mensaje',13,10,'$'
    msgFIN db 'Fin del programa',13,10,'$'

.code

main proc
    mov dx,@DATA
    mov ds,dx
    xor dx,dx

    print msgWelcome
    call cambiartodoavideo
    print msg4

    print msgFIN
    .exit
main endp

cambiartodoavideo proc
    print msg1
    print msg2
    print msg4
    ret
cambiartodoavideo endp

end main
```

1. **Configuración base**: estructura estándar (`.model small`, `.stack`, `.data`, `.code`). `main` como punto de entrada.
2. **Mensajes**: variables (`msgWelcome`, `msg1`...`msg4`, `msgFIN`) declaradas con `DB`, con `13,10` (retorno de carro + salto de línea) y terminadas en `$` para la interrupción de impresión.
3. **Procedimiento** `cambiartodoavideo`: agrupa varias llamadas a la macro `print` y usa `RET` para volver al flujo de `main`.
4. **Macro `print`**: definida en archivo externo `macros.asm`, recibe el parámetro `cadena` y encapsula `MOV AH,09h` + `MOV DX, OFFSET cadena` + `INT 21h`.
5. **Integración**: `include macros.asm` en el archivo principal para invocar `print nombreVariable` en vez de repetir las instrucciones de la interrupción 21h constantemente.
6. **Flujo del programa**: imprime un mensaje de bienvenida, llama al procedimiento `cambiartodoavideo` (que imprime varios mensajes), imprime otro mensaje, y termina con `.exit`.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (Assembler)
- Microsoft Macro Assembler (MASM)
- Editor de texto para código fuente

## Problemas o errores
- **Error de compilación**: usar una macro no definida o no incluida generó un "syntax error"; se resolvió con la directiva `INCLUDE` apuntando al archivo donde residía la macro.
- **Omisión de salida**: en un punto inicial faltó la interrupción de finalización del programa (`AX=4C00h`), causando comportamiento inesperado; se resolvió agregando el bloque de cierre correspondiente.

## Conclusiones / cierre
Se logró un programa modular, evitando la repetición excesiva de código mediante macros (impresión) y procedimientos (organización de la lógica). Queda pendiente para futuros videos explorar macros para lectura de archivos y obtención de la hora del sistema.

## Timestamps clave
- 0:10 — Teoría de los procedimientos
- 1:26 — Funcionamiento de CALL y RET (pila)
- 4:47 — Cómo crear un procedimiento (sintaxis PROC/ENDP)
- 7:58 — Teoría de las macros
- 12:52 — Características especiales (parámetros y etiquetas locales)
- 16:37 — Parte práctica
- 22:38 — Creación del archivo de macros y uso de INCLUDE
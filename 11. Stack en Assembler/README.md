# Stack en Assembler

- **Link:** https://youtu.be/TpZPNmr_Ij0
- **Video #:** 12
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/11.%20Stack%20en%20Assembler
  - `main.asm`

## Tema general
Concepto, funcionamiento y utilidad de la pila (stack) en ensamblador (pilas estáticas). Ejercicio práctico de gestión de registros y datos temporales usando `PUSH` y `POP`.

## Qué se explicó / enseñó
- **Estructura LIFO** (Last In, First Out): el último elemento en entrar es el primero en salir.
- **Apuntador (tope/top)**: referencia la posición del último dato insertado.
- **Métodos principales**: `PUSH` (insertar), `POP` (extraer y remover), y `PEEK` (consultar sin remover — no es instrucción nativa de ASM, se explica solo conceptualmente).
- **Pilas estáticas**: al hacer `POP` no se borra físicamente el dato en memoria, solo se mueve el puntero del tope, permitiendo sobrescritura con nuevos `PUSH`.
- **Implementación en MASM**: directiva `.stack` (por defecto 1024 bytes).
- **Tamaño de elementos**: en ensamblador de 16 bits, cada elemento del stack ocupa 2 bytes (16 bits), igual al tamaño de registros como AX.
- **Restricciones técnicas**: `PUSH`/`POP` solo permiten registros de 16 bits (AX, DX, etc.), no de 8 bits.
- **Aplicación práctica**: resguardo temporal de valores en registros para permitir interrupciones (imprimir cadenas con `9H` o caracteres con `2H`) sin perder información crítica.

## Qué se hizo (paso a paso)

Objetivo del ejercicio: pedir 2 caracteres al usuario (con sus mensajes), mostrarlos en el orden ingresado, y mostrar un mensaje de finalización — usando solo AX y DX.

```asm
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
    mov dx, offset msgWelwome ; dx -> inicio de direccion de memoria donde comenzara a imprimir
    mov ah,9h ; ah -> indica que se imprimira una cadena
    int 21h ; imprime desde el inicio hasta encontrar el caracter $

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
```

1. **Inicialización** del segmento de datos (`@Data`) y segmento de código.
2. **Mensajes de texto** finalizados con `$` para imprimirse con `INT 21H` (función `9h`).
3. **Programa**: solicita dos caracteres al usuario y los imprime, usando la pila para resguardar los registros durante el flujo.
4. **PUSH AX/DX** para guardar los estados de los registros antes de imprimir una cadena o pedir un carácter.
5. **POP**: al recuperar los datos, por la naturaleza LIFO el orden salía invertido. Se resolvió reordenando mediante pasos intermedios adicionales de `PUSH`/`POP` para imprimir los caracteres en el orden original de ingreso.
6. **Decisión de diseño**: se evitó el uso excesivo de variables de memoria, optando por el stack para no desperdiciar recursos y optimizar el manejo de los registros limitados.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (x86)
- MASM (Microsoft Macro Assembler)
- Emu8086 (emulador)
- Interrupciones del DOS (INT 21H)

## Problemas o errores
- **Impresión todo junto**: faltaban retornos de carro y saltos de línea. Se resolvió añadiendo los caracteres ASCII 10 (LF) y 13 (CR) en las cadenas.
- **Impresión en orden inverso**: al hacer `POP` de los registros, el orden salía invertido (B, A en vez de A, B). Se resolvió gestionando el stack con instrucciones adicionales de `PUSH` para reordenar los valores antes de la salida final.
- **Confusión de interrupciones**: se intentó usar `9H` para imprimir un carácter (siendo para cadenas); se corrigió usando `2H` para caracteres.

## Conclusiones / cierre
Se consolidó el uso de la pila para almacenamiento temporal de estados de registros. El código se volvió "engorroso" por la repetición manual de interrupciones — se introduce el tema de Macros y Procedimientos en el siguiente video como solución para modularizar el código.

## Timestamps clave
- 0:01 - Introducción pilas y como funcionan
- 10:42  - Stack en assembler
- 19:09 - Aplicaciones del stack en assembler
- 24:39 - Enunciado parte práctica 
- 26:45 - Interrupciones a usar en la práctica
- 29:00 - Inicio desarollo de la práctica
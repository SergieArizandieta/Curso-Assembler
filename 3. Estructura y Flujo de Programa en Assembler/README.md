# Estructura y Flujo de Programa en Assembler

- **Link:** https://youtu.be/kr6f1XUxZKI
- **Video #:** 4
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/3.%20Estructura%20y%20Flujo%20de%20Programa%20en%20Assembler
  - `Flujo.asm`, `Lectura.asm` (vacío/plantilla), `main.asm`

## Tema general
Estructura obligatoria y flujo de ejecución de un programa en ensamblador para MASM: cómo se organizan los segmentos y cómo se comporta el procesador al ejecutarlos.

## Qué se explicó / enseñó
- **MASM no distingue mayúsculas/minúsculas** (case-insensitive).
- **Importación de macros**: directiva `include` para invocar archivos externos (ej. `Lectura.asm`), funcionando como método para modularizar el código principal.
- **Modelo de programa** (`.model`):
  - **Tiny**: datos y código en el mismo segmento de 64KB.
  - **Small**: datos y código en segmentos distintos, 64KB cada uno.
  - **Medium**: datos 64KB, código mayor.
  - **Large**: ambos mayores a 64KB.
- **Segmento de pila** (`.stack`): define el tamaño de la pila en memoria; si no se especifica, usa el valor por defecto de 1024 bytes.
- **Segmento de datos** (`.data`): para declarar variables.
- **Segmento de código** (`.code`): donde reside la lógica principal.
- **Finalización**: `end Main` indica el fin de la ejecución.
- **Flujo de control**: ejecución *top-down* (de arriba hacia abajo). Uso de etiquetas (labels) como puntos de referencia para saltos de ejecución y creación de bucles.

## Qué se hizo (paso a paso)
Se construyó la estructura básica del programa apilando las secciones en orden:

```asm
include Lectura.asm ;Importación de macros

.model small ;Declaración del programa

.stack ;Segmento de pila (1024) por defecto

.data ;Segmento de datos
;--------Todas las declaraciones--------
;var 1
;var 2
;var 3
;var N

.code ;Segmento de código
;--------Código--------

;--------Declaracion del main --------
;       Instrucciones del main
;--------Termina del main --------

;--------Declaracion de otro método --------
;       Instrucciones otro método
;--------Termina  otro método -------

;-------- Más código -------

end main
```

1. `include archivo.asm` — opcional, para macros. Decisión de diseño: `.model small` recomendado por el autor por ser suficiente para la mayoría de proyectos académicos.
2. `.stack` — se usa el valor por defecto de 1024.
3. `.data` — aquí se colocan las variables.
4. `.code` — bloque principal.
5. **Definición de procedimiento**: `Main proc` / `Main endp` para encapsular el código dentro del segmento de código.
6. **Demostración de etiquetas** (`Flujo.asm`):
   ```asm
   .model small
   .stack
   .data
   .code

       main PROC

           ;Instruccion 1
           ;Instruccion 2

           Etiqueta1:
           ;Instruccion 3
           ;Instruccion 4
           ;Instruccion 5
           ;Instruccion 6

           Etiqueta2:
           ;Instruccion 7
           ;Instruccion 8

           ;Instruccion 9

       main ENDP

   end main
   ```
   Una etiqueta (`Etiqueta1:`) funciona como identificador para saltos; es ignorada por el flujo secuencial natural hasta que una instrucción de salto hace que el puntero regrese a esa dirección, creando un bucle.

## Herramientas / tecnologías mencionadas
- Microsoft Macro Assembler (MASM)
- GitHub (acceso a ejemplos de código)

## Problemas o errores
No hubo errores de compilación durante el video, pero se advirtió que el **orden de las directivas** (modelo, stack, data, code) es estrictamente obligatorio para que el ensamblador pueda generar el ejecutable.

## Conclusiones / cierre
Se consolidó una plantilla base para cualquier programa en ensamblador. El flujo *top-down* y el uso de etiquetas son los pilares para controlar el programa. Se anunció que en el siguiente video se trabajará el "Hola Mundo" y el uso de documentos de apoyo.

## Timestamps clave
- 0:16 — Sensibilidad a mayúsculas (case-insensitive)
- 1:03 — Importación de macros (include)
- 2:16 — Declaración del modelo (.model)
- 3:56 — Segmento de pila (.stack)
- 5:11 — Segmento de datos (.data)
- 6:01 — Segmento de código (.code)
- 8:12 — Flujo Top-Down y uso de etiquetas
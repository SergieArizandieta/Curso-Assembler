# Hola Mundo en Assembler y Documentos de Apoyo

- **Link:** https://youtu.be/JxyB4vZ6a5Y
- **Video #:** 5
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/4.%20Hola%20Mundo%20en%20Assembler%20y%20Documentos%20de%20Apoyo
  - `main.asm`
  - `Links.txt` (recursos de apoyo)

## Tema general
Creación de un programa básico de Hola Mundo en Assembler, explicando la estructura esencial del código y recursos externos para consultar instrucciones y registros.

## Qué se explicó / enseñó
- **Modelo de memoria**: uso del modelo `small`, adecuado para programas sencillos.
- **Segmentación**: el lenguaje trabaja mediante segmentos separados (datos, pila y código).
- **Variables**: declaración de variables de tipo texto finalizadas con un carácter de control (`$`).
- **Registros**: mención breve como elementos de almacenamiento interno del procesador (resaltados en el editor).
- **Mnemónicos**: palabras clave en ensamblador que sustituyen a los códigos máquina (0s y 1s).
- **Interrupciones**: introducción a `int 21h` como mecanismo para interactuar con el sistema operativo (en este caso, imprimir en consola).
- **Recursos de apoyo** recomendados:
  - http://sistel.xp3.biz
  - https://helppc.netcore2k.net/topics

## Qué se hizo (paso a paso)
```asm
.model small
.stack

.data
    msg db "Hello World Curso Assembler!!!$"

.code
main PROC

;Carga de segmento de datos a segmento de codigo
    mov ax,@data
    mov ds,ax

;impresion en consola
    mov dx, offset msg
    mov ah,9
    int 21h
.exit

main ENDP

end main
```

1. **Declaración de modelo y pila**: `.model small` y `.stack` (1024 por defecto).
2. **Segmento de datos**: variable `msg` con `db` (define byte) y el texto, finalizando con `$` para marcar el fin de la cadena.
3. **Inicialización del segmento de datos**: `mov ax, @data` + `mov ds, ax` — carga la dirección del segmento de datos en el registro DS para poder acceder a las variables.
4. **Impresión en consola**:
   - `mov dx, offset msg` — carga la dirección de la variable en DX.
   - `mov ah, 09h` — prepara la función 09h (impresión de cadena).
   - `int 21h` — ejecuta la interrupción para hacer la llamada al sistema.
5. **Finalización**: `.exit` para terminar el programa correctamente.
6. **Compilación**: mediante DOSBox usando el comando `ML` indicando el nombre del archivo fuente.

## Herramientas / tecnologías mencionadas
- Lenguaje Assembler (MASM)
- DOSBox
- Editor de texto (genérico, sin especificar)
- GitHub (acceso al código fuente del curso)

## Problemas o errores
No se reportaron errores de compilación; el proceso finalizó mostrando el mensaje esperado en pantalla tras compilar `main.asm`.

## Conclusiones / cierre
Se logró imprimir con éxito el mensaje en consola. El autor enfatizó que este es un nivel inicial y que los temas complejos (registros, mnemónicos, interrupciones) se tratarán a profundidad en capítulos futuros. Próximo tema: registros.

## Timestamps clave
- 0:59 — Declaración del modelo y segmento de pila
- 1:30 — Definición del segmento de datos y variables
- 3:19 — Inicialización de segmentos (AX y DS)
- 4:07 — Lógica de impresión en consola
- 5:33 — Explicación de conceptos inmersos (datos, registros, mnemónicos, interrupciones)
- 7:05 — Presentación de documentos de apoyo y sitios web de consulta
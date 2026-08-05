# Instalación de MASM, DOSBox, Emu8086 | Windows 11

- **Link:** https://www.youtube.com/watch?v=HXIp5jM0MoE
- **Video #:** 3
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/2.%20Instalaci%C3%B3n%20de%20MASM%2C%20DOSbox%2C%20Emu8086
- **Archivo de prueba:** https://raw.githubusercontent.com/SergieArizandieta/Curso-Assembler/refs/heads/main/2.%20Instalaci%C3%B3n%20de%20MASM%2C%20DOSbox%2C%20Emu8086/Hola.asm

## Tema general
Configuración del entorno de desarrollo para programar en ensamblador sobre Windows 11: instalación y montaje de las herramientas necesarias para emular un entorno DOS y compilar código fuente en ensamblador.

## Qué se explicó / enseñó
- **Emu8086 y DOSBox**: emuladores/debuggers para ensamblador.
- **MASM (Microsoft Macro Assembler)**: debe instalarse obligatoriamente en el disco C para evitar errores de ruta.
- **Terminal de DOSBox**: montaje de unidades virtuales (`mount`) para mapear carpetas locales a unidades accesibles por el emulador.
- **Estructura básica de un .asm**: `.model small`, `.stack`, segmento `.data` (variables) y segmento `.code` (lógica del programa).
- **Interrupciones de DOS**: `int 21h` para funciones del sistema — específicamente la función 9 para imprimir cadenas de caracteres.
- **Ensamblador ML**: ejecutable encargado de compilar el código fuente (`.asm`) a un ejecutable (`.exe`).
- **Automatización de comandos**: uso del archivo de configuración de DOSBox (`dosbox.conf`) para ejecutar comandos de montaje al inicio.

## Qué se hizo (paso a paso)
1. **Descarga e instalación**: Emu8086 y DOSBox en rutas personalizadas; MASM copiado directamente en `C:\masm611`.
2. **Montaje inicial en DOSBox**:
   ```
   mount c: c:\masm611
   c:
   disk1\setup.exe
   ```
   para instalar el compilador.
3. **Creación del programa `Hola.asm`**:
   ```asm
   .model small
   .stack

   .data
       msg db 'Hello World $'

   ; segmento de codigo
   .code

       ; procedimiento principal main
       main PROC

           ; carga en memoria las variables del segmento de datos
           MOV ax, @data
           MOV ds, ax
           xor ax,ax

           ; impresion por pantalla
           mov dx, offset msg
           mov ah, 9
           int 21h
           .exit

       main ENDP

   end main
   ```
   - `MOV ax, @data` + `MOV ds, ax`: cargan el segmento de datos.
   - `xor ax, ax`: limpia registros.
   - `mov dx, offset msg` + `mov ah, 9` + `int 21h`: función 9 de DOS para mostrar el mensaje en pantalla.
   - `.exit`: finaliza correctamente el procedimiento.
4. **Compilación**:
   ```
   cd masm611
   cd bin
   ml asm\prueba\hola.asm
   hola.exe
   ```
5. **Automatización**: se editó el archivo de configuración (options) de DOSBox agregando al final los comandos de montaje, para no repetirlos manualmente cada vez que se abre el programa.

## Herramientas / tecnologías mencionadas
- Microsoft Macro Assembler (MASM 6.11)
- DOSBox
- Emu8086
- Windows 11
- Lenguaje Ensamblador (x86)

## Problemas o errores
- **Error**: al ejecutar el comando `ML` desde una carpeta distinta a `bin`.
  - **Razón**: el programa ML no estaba en la ruta de trabajo actual del emulador.
  - **Resolución**: navegar explícitamente a la carpeta `bin` antes de ejecutar el ensamblador, o especificar la ruta completa del archivo al ejecutar el comando.
- **Advertencia**: dificultad para teclear el símbolo `\` (backslash) en teclados en español dentro de DOSBox; se sugiere usar la tecla que el emulador mapea para ese símbolo.

## Conclusiones / cierre
Se logró un entorno funcional para escribir, ensamblar y ejecutar programas sencillos de ensamblador en Windows 11. Se mencionó que dentro de MASM existen carpetas de "samples" con ejemplos adicionales para explorar por cuenta propia.

## Timestamps clave
- 0:17 — Inicio de descarga de herramientas
- 2:27 — Instalación de MASM en disco C
- 4:00 — Primer montaje en DOSBox y ejecución de setup
- 8:20 — Explicación del compilador ML
- 9:06 — Creación y explicación del archivo Hola.asm
- 11:15 — Automatización de comandos al inicio de DOSBox
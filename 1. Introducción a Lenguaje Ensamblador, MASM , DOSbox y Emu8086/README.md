# Introducción a Lenguaje Ensamblador, MASM, DOSBox y Emu8086

- **Link:** https://www.youtube.com/watch?v=ZIvQbBEkOtI
- **Video #:** 2
- **GitHub (carpeta de la clase):** https://github.com/SergieArizandieta/Curso-Assembler/tree/main/1.%20Introducci%C3%B3n%20a%20Lenguaje%20Ensamblador%2C%20MASM%20%2C%20DOSbox%20y%20Emu8086 (sin código aún, solo agradecimiento)
- **Presentación (Canva):** https://canva.link/j89ris3daa4p9o1

## Tema general
Introducción teórica al lenguaje ensamblador: qué es, cómo funcionan los nemotécnicos, y presentación del ecosistema de herramientas (MASM, DOSBox y Emu8086) necesarias para programar y ejecutar código en este entorno.

## Qué se explicó / enseñó
- **Lenguaje Ensamblador**: evolución más flexible e intuitiva del lenguaje máquina; lenguaje de bajo nivel con instrucciones limitadas (a diferencia de lenguajes de alto nivel con estructuras como ciclos `for`).
- **Nemotécnicos**: palabras en inglés que reemplazan secuencias binarias (código máquina) para facilitar la escritura. Ej.: `ADD` en lugar de una secuencia de unos y ceros para sumar.
- **Sintaxis de Intel** (usada por MASM): estructura de instrucción = nemotécnico (operación), operando destino, operando fuente. Ej.: `ADD AX, 4` → suma 4 al registro AX.
- **DOS (Disk Operating System)**: sistema encargado de administración de archivos, recursos del sistema y control de hardware; necesario para ejecutar el código ensamblador escrito en MASM.
- **DOSBox**: simulador (similar a una máquina virtual) que permite ejecutar el entorno DOS en sistemas modernos.
- **Emu8086**: emulador de microprocesadores Intel/AMD 8086 con ensamblador integrado; permite visualizar el flujo del programa paso a paso y observar cambios en variables y registros en tiempo real.

## Qué se hizo (paso a paso)
No hubo sesión de codificación completa; fue una demostración conceptual del flujo de trabajo y sintaxis:
1. Ejemplo de instrucción `ADD AX, 4` para ilustrar cómo el operando fuente (4) se suma al operando destino (AX).
2. Análisis del propósito de Emu8086: entender las bases de las instrucciones observando internamente qué sucede en el procesador (el autor aclara que es ineficiente para programas largos o complejos).
3. Decisión de herramientas: MASM + DOSBox para el flujo principal del curso; Emu8086 se reserva para fines didácticos y de visualización.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (Assembler)
- MASM (Microsoft Macro Assembler)
- DOSBox
- DOS (Disk Operating System)
- Emu8086
- Visual Studio Code (editor sugerido)

## Problemas o errores
No se presentaron errores técnicos; sesión introductoria de conceptos teóricos.

## Conclusiones / cierre
Se estableció el mapa de ruta del curso y el propósito de cada herramienta. Queda pendiente para el próximo video: instalación técnica de MASM, DOSBox y Emu8086.

## Timestamps clave
- 0:17 — Introducción al Lenguaje Ensamblador y sus características
- 1:33 — Qué es un nemotécnico
- 2:24 — Explicación de MASM y la sintaxis de Intel
- 3:20 — Definición de DOS y uso de DOSBox
- 4:42 — Explicación de Emu8086 y su utilidad de depuración
- 5:37 — Cierre y mención del siguiente capítulo (instalación de herramientas)
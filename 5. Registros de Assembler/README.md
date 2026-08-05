# Registros de Assembler

- **Link:** https://youtu.be/0wCCfmfkpbo
- **Video #:** 6
- **GitHub:** no aplica (video teórico, sin código)

## Tema general
Estructura, funcionamiento y división de los registros en ensamblador: cómo interactúan registros de distintos tamaños (8, 16 y 32 bits) y cuáles son los registros multipropósito y de bandera más importantes.

## Qué se explicó / enseñó
- **Bits y bytes**: 8 bits = 1 byte. Límite de capacidad según el tamaño del registro (8, 16, 32 bits) y conversión de binario a decimal.
- **Estructura interna de los registros**: un registro grande (ej. `EAX` de 32 bits) contiene registros menores. `EAX` incluye `AX` (16 bits), que se divide en `AH` (parte alta, 8 bits) y `AL` (parte baja, 8 bits). Modificar una parte afecta al registro completo.
- **Reglas de operación**: no se pueden combinar registros de diferentes tamaños en una misma instrucción (ej. no sumar 16 bits con 8 bits) — deben ser del mismo tamaño, o genera error.
- **Clasificación de registros**:
  - **Multipropósito**: `EAX` (acumulador, operaciones matemáticas), `EBX` (índice base, memoria), `ECX` (conteo, bucles y desplazamientos), `EDX` (datos, resultados de multiplicación/división).
  - **Registros de índice**: `EDI` (destino) y `ESI` (origen), usados para acceso a cadenas de datos o arreglos.
  - **Registros de bandera**: registro de estado `EFLAGS`, con foco en la bandera Zero (`ZF`), que cambia a 1 si el resultado de una operación es cero.

## Qué se hizo
No hubo sesión de programación ni IDE; fue una explicación teórica mediante gráficos y diagramas:
- Análisis comparativo de cómo se dividen los registros A, B, C y D.
- Explicación de cómo `ESI` y `EDI` funcionan como punteros especializados para estructuras como arreglos.

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (Assembler)
- Registros de procesador (EAX, EBX, ECX, EDX, ESI, EDI, AH, AL, etc.)
- Registros de bandera (EFLAGS)

## Problemas o errores
No hubo errores de ejecución (lección teórica). Se advirtió sobre el error lógico de operar registros de distinto tamaño (ej. sumar un registro de 16 bits con uno de 8 bits).

## Conclusiones / cierre
Se estableció una base teórica sólida sobre manejo de registros, tamaños de bits y organización de memoria mediante índices. Queda pendiente para próximos capítulos: práctica de estas instrucciones y estudio detallado de los registros de banderas (EFLAGS).

## Timestamps clave
- 0:13 — Definiciones de bits y bytes
- 0:26 — Tamaños de registros (8, 16, 32 bits)
- 4:13 — Estructura y división del registro A (EAX, AX, AH, AL)
- 9:03 — Reglas de operación entre tamaños de registros
- 14:28 — Registros multipropósito (EAX, EBX, ECX, EDX)
- 16:39 — Registros de índice (ESI, EDI)
- 17:14 — Introducción a registros de banderas (EFLAGS)
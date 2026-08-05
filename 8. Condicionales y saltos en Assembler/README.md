# Condicionales y Saltos en Assembler

- **Link:** https://youtu.be/ZoEfOgAsnDs
- **Video #:** 9
- **GitHub:** no proporcionado

## Tema general
Uso de etiquetas, saltos condicionales e incondicionales para controlar el flujo de ejecución en ensamblador, permitiendo implementar estructuras de control como `if` y la base para ciclos.

## Qué se explicó / enseñó
- **Etiquetas (labels)**: puntos de anclaje en el código marcados con un nombre seguido de dos puntos. No afectan la ejecución anterior o posterior, solo sirven como referencia para saltos.
- **Flujo normal de ejecución**: top-down, secuencial, hasta que una instrucción de salto lo altera.
- **Saltos condicionales**: evalúan una condición y, si se cumple, redirigen el flujo a una etiqueta específica.
- **Saltos incondicionales** (`jump`/`jmp`): obligan a saltar a una etiqueta sin evaluar ninguna condición, alterando permanentemente el flujo.
- **CMP (compare)**: realiza una resta interna (A - B) sin modificar los registros, solo actualiza el estado (flags) para comparaciones posteriores.
- **Números con signo vs. sin signo**: el procesador interpreta números con signo usando el bit más significativo como signo; esto determina qué nemónicos de salto usar.
- **Nemónicos de salto**:
  - Sin signo: `JA`, `JAE`, `JB`, `JBE`
  - Con signo: `JG`, `JGE`, `JL`, `JLE`
  - Por resultado de comparación: `JE`/`JZ` (si es igual), `JNE`/`JNZ` (si es diferente)

## Qué se hizo (paso a paso)
1. Construcción conceptual de un `if` mediante saltos: si A == B, saltar a L1; si no, ejecutar la siguiente línea y saltar incondicionalmente a L2.
2. Comparación técnica: `cmp ax, bx` seguido de `je etiqueta` para verificar igualdad.
3. Dos estrategias para implementar un condicional:
   - Saltar a una etiqueta interna si se cumple la condición.
   - Saltar a una etiqueta externa si la condición **no** se cumple (negación lógica) — optimizando el flujo según el caso de uso.
4. Transformación de lógica de alto nivel a bajo nivel usando `cmp`, `je` (jump if equal), `jne` (jump if not equal) y `jmp` (jump).

## Herramientas / tecnologías mencionadas
- Lenguaje Ensamblador (Assembler)
- Registros de CPU (genérico)
- Conceptos de binario, hexadecimal y decimal

## Problemas o errores
No hubo errores de ejecución durante el video. Se hizo énfasis en el error lógico común de confundir los saltos para números con signo vs. sin signo — el programador debe decidir bajo qué formato tratará sus datos.

## Conclusiones / cierre
Se logró entender cómo construir estructuras de control personalizadas tipo `if` y la base para futuros ciclos (loops). El siguiente capítulo cubrirá la implementación práctica de estructuras cíclicas: `while`, `for`, `do-while` y sentencias anidadas.

## Timestamps clave
- 0:12 — Introducción a las etiquetas (ganchos)
- 2:46 — Cómo los saltos cambian el flujo de ejecución
- 11:42 — Cómo construir un IF en ensamblador
- 17:34 — Funcionamiento de las comparaciones (CMP) y las banderas
- 22:09 — Diferencia entre números con signo y sin signo
- 25:34 — Tabla de nemónicos para saltos condicionales
- 27:41 — Saltos incondicionales (JMP)
- 29:07 — Ejemplo completo de conversión de código de alto a bajo nivel
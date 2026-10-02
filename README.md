# Diseño de una solución de networking escalable y resiliente

El candidato debe diseñar una solución de networking que soporte la estrategia de nube de cualquier tamaño, utilizando componentes de alta escalabilidad y resiliencia como Transit Gateway, VPN redundantes, Direct Connect y NAT Gateway. Además, debe definir un esquema de direccionamiento que considere el crecimiento orgánico de cada caso. La solución debe permitir conexiones entre nube, on-premise y entre VPCs.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Definiciones de redes |
| **Nivel** | advanced-l3 |
| **Tipo** | practical |
| **Tiempo estimado** | 10 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Definición de requisitos

**Objetivo:** Identificar y documentar los requisitos de la solución de networking.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Enumera los componentes de networking necesarios para la solución.
- Define los criterios de escalabilidad y resiliencia que deben cumplirse.
- Especifica las conexiones necesarias entre nube, on-premise y VPCs.

**Entregable:** Documento de requisitos de la solución de networking.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el crecimiento orgánico de la red.
- Evalúa la necesidad de redundancia en las conexiones.

</details>

### Fase 2: Diseño del esquema de direccionamiento

**Objetivo:** Crear un esquema de direccionamiento que considere el crecimiento orgánico de la red.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Define el espacio de direcciones para la red.
- Considera la segmentación de la red en subredes.
- Evalúa el impacto del crecimiento orgánico en el esquema de direccionamiento.

**Entregable:** Esquema de direccionamiento documentado.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza CIDR para definir el espacio de direcciones.
- Considera la necesidad de segmentación para mejorar la seguridad y el rendimiento.

</details>

### Fase 3: Implementación de la solución de networking

**Objetivo:** Implementar la solución de networking utilizando los componentes definidos.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Configura los componentes de networking según los requisitos definidos.
- Verifica la conectividad entre nube, on-premise y VPCs.
- Realiza pruebas de escalabilidad y resiliencia.

**Entregable:** Solución de networking implementada y documentada.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza Transit Gateway para centralizar la conectividad.
- Configura VPN redundantes para mejorar la resiliencia.
- Implementa Direct Connect para conexiones de alta velocidad.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una solución de networking escalable y resiliente?
- **paraQueSirve**: ¿Para qué sirve definir un esquema de direccionamiento en una solución de networking?
- **comoSeUsa**: ¿Cómo se usa Transit Gateway en una solución de networking?
- **erroresComunes**: ¿Cuáles son los errores comunes al diseñar una solución de networking?
- **queDecisionesImplica**: ¿Qué decisiones implica la implementación de una solución de networking?

## Criterios de Evaluacion

- Identificar y documentar los requisitos de la solución de networking.
- Crear un esquema de direccionamiento que considere el crecimiento orgánico de la red.
- Implementar la solución de networking utilizando los componentes definidos.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*

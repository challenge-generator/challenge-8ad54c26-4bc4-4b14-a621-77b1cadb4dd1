# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Diseño de una solución de networking escalable y resiliente**.

| | |
|---|---|
| Tema | Definiciones de redes |
| Nivel | advanced-l3 |
| Chapter | Cloud Ops |
| Especialidad | AWS |
| Stack | Terraform / AWS Provider |
| Patron arquitectonico | modular con landing zone y gobierno multi-cuenta |
| Tiempo estimado | 10 horas |

## Receta del stack

Esqueleto obligatorio:

- `main.tf, variables.tf, outputs.tf y providers.tf en la raiz`
- `modules/ con al menos un modulo propio`
- `environments/{dev,qa,prod}/terraform.tfvars`
- `backend.tf con el estado remoto`
- `README.md con el diagrama de la topologia`

Trampas conocidas:

- `required_version` de Terraform se declara como RANGO (`>= 1.5`), nunca como version exacta (`= 1.7.0` ni `"1.7.0"`). Pineado exacto, el proyecto no corre con ninguna otra version instalada y el participante no puede ni inicializarlo.
- Lo mismo con los providers: `version = "~> 5.0"`, no una version exacta.
- Cada variable de `variables.tf` lleva su valor en `environments/{env}/terraform.tfvars`, no un `default` en la declaracion.

Dependencias:

- hashicorp/aws ~> 5.0
- terraform >= 1.5

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `terraform init -backend=false && terraform validate && terraform fmt -check` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `terraform init -backend=false && terraform validate && terraform fmt -check` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Definición de requisitos**: Documento de requisitos de la solución de networking.
- **Fase 2 — Diseño del esquema de direccionamiento**: Esquema de direccionamiento documentado.
- **Fase 3 — Implementación de la solución de networking**: Solución de networking implementada y documentada.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

No se detectaron huecos: estan los archivos declarados, el boilerplate del stack y ninguna referencia quedo colgando. Igual corre el comando de verificacion — que los archivos existan no garantiza que compilen.

### Presentes (24)

- `variables.tf`
- `providers.tf`
- `modules/networking/variables.tf`
- `modules/transit_gateway/variables.tf`
- `modules/vpn/variables.tf`
- `modules/direct_connect/variables.tf`
- `modules/nat_gateway/variables.tf`
- `modules/networking/main.tf`
- `modules/networking/outputs.tf`
- `modules/transit_gateway/main.tf`
- `modules/transit_gateway/outputs.tf`
- `modules/vpn/main.tf`
- `modules/vpn/outputs.tf`
- `modules/direct_connect/main.tf`
- `modules/direct_connect/outputs.tf`
- `modules/nat_gateway/main.tf`
- `modules/nat_gateway/outputs.tf`
- `main.tf`
- `outputs.tf`
- `backend.tf`
- `README.md`
- `environments/dev/terraform.tfvars`
- `environments/qa/terraform.tfvars`
- `environments/prod/terraform.tfvars`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `modules/networking`
- `modules/transit_gateway`
- `modules/vpn`
- `modules/direct_connect`
- `modules/nat_gateway`
- `environments/dev`
- `environments/qa`
- `environments/prod`

## Verificacion

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **modular con landing zone y gobierno multi-cuenta**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Cloud Ops, Especialidad Arquitectura, Tecnología AWS, Advanced
- Brecha que el reto ataca: Es capaz de definir e implementar una solución de Networking qué soporte la estrategia de nube de cualquier tamaño con componentes de alta escalabilidad y resiliencia cómo Transit gateway, vpn redundantes, Direct connect, NAT Gateway y es capaz de definir un esquema de direccionamiento teniendo en cuenta el crecimiento orgánico de cada caso. Tiene claro cómo usar conexiones entre nube, onpremise y entre VPCs.
- Mision: Candidato con experiencia avanzada en arquitectura de nube.

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*

# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Arquitectura, Tecnología AWS, Advanced

### Brecha de conocimiento
Es capaz de definir e implementar una solución de Networking qué soporte la estrategia de nube de cualquier tamaño con componentes de alta escalabilidad y resiliencia cómo Transit gateway, vpn redundantes, Direct connect, NAT Gateway y es capaz de definir un esquema de direccionamiento teniendo en cuenta el crecimiento orgánico de cada caso. Tiene claro cómo usar conexiones entre nube, onpremise y entre VPCs.

### Misión / candidato
Candidato con experiencia avanzada en arquitectura de nube.

### Reto
- Tema: Definiciones de redes
- Seniority: advanced-l3
- Tipo: practical
- Título: Diseño de una solución de networking escalable y resiliente
- Tiempo estimado: 10 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Definición de requisitos — objetivo: Identificar y documentar los requisitos de la solución de networking. — entregable (NO resolver): Documento de requisitos de la solución de networking.
- Fase 2: Diseño del esquema de direccionamiento — objetivo: Crear un esquema de direccionamiento que considere el crecimiento orgánico de la red. — entregable (NO resolver): Esquema de direccionamiento documentado.
- Fase 3: Implementación de la solución de networking — objetivo: Implementar la solución de networking utilizando los componentes definidos. — entregable (NO resolver): Solución de networking implementada y documentada.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: variables.tf ===
# variables.tf - Declaración de variables globales para la solución de networking
# Estas variables serán utilizadas en los módulos de networking, Transit Gateway, VPN y Direct Connect.

# CIDR block principal para la VPC principal
variable "vpc_cidr" {
  description = "CIDR block principal para la VPC. Debe ser lo suficientemente grande para soportar subredes públicas y privadas."
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El valor proporcionado para vpc_cidr debe ser un CIDR block válido (ej. 10.0.0.0/16)."
  }
}

# CIDR blocks para subredes públicas
variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para subredes públicas. Cada CIDR debe estar dentro del rango de la VPC."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en public_subnet_cidrs deben ser válidos."
  }
}

# CIDR blocks para subredes privadas
variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para subredes privadas. Cada CIDR debe estar dentro del rango de la VPC."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.private_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en private_subnet_cidrs deben ser válidos."
  }
}

# Regiones para despliegue
variable "regions" {
  description = "Lista de regiones AWS donde se desplegarán los recursos de networking."
  type        = list(string)
  default     = ["us-east-1", "us-west-2"]
}

# Tags para los recursos
variable "tags" {
  description = "Mapa de tags que se aplicarán a todos los recursos para optimización de costos y gestión."
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "networking-solution"
    Owner       = "cloud-ops"
  }
}

# CIDR blocks para conexiones VPN
variable "vpn_cidr_blocks" {
  description = "Lista de CIDR blocks para conexiones VPN. Estos deben ser distintos a los CIDR blocks de la VPC."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.vpn_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en vpn_cidr_blocks deben ser válidos."
  }
}

# IPs de Customer Gateway para VPN
variable "customer_gateway_ips" {
  description = "Lista de IPs públicas de los Customer Gateways para conexiones VPN."
  type        = list(string)
  validation {
    condition     = alltrue([for ip in var.customer_gateway_ips : can(cidrhost("${ip}/32", 0))])
    error_message = "Todas las IPs en customer_gateway_ips deben ser direcciones IP públicas válidas."
  }
}

# CIDR blocks para conexiones Direct Connect
variable "direct_connect_cidr_blocks" {
  description = "Lista de CIDR blocks para conexiones Direct Connect. Estos deben ser distintos a los CIDR blocks de la VPC y VPN."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.direct_connect_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en direct_connect_cidr_blocks deben ser válidos."
  }
}

# ASN para Transit Gateway
variable "transit_gateway_asn" {
  description = "Número de sistema autónomo (ASN) para el Transit Gateway. Debe estar en el rango privado (64512-65534)."
  type        = number
  validation {
    condition     = var.transit_gateway_asn >= 64512 && var.transit_gateway_asn <= 65534
    error_message = "El ASN para Transit Gateway debe estar en el rango privado (64512-65534)."
  }
}

# Nombre del Transit Gateway
variable "transit_gateway_name" {
  description = "Nombre del Transit Gateway para identificación."
  type        = string
  default     = "main-transit-gateway"
}

# Habilitar propagación de rutas en Transit Gateway
variable "transit_gateway_enable_route_propagation" {
  description = "Indica si se habilita la propagación de rutas en el Transit Gateway."
  type        = bool
  default     = true
}

# Habilitar DNS support en Transit Gateway
variable "transit_gateway_enable_dns_support" {
  description = "Indica si se habilita el soporte DNS en el Transit Gateway."
  type        = bool
  default     = true
}

# Habilitar Amazon side ASN en Transit Gateway
variable "transit_gateway_enable_amazon_side_asn" {
  description = "Indica si se habilita el ASN en el lado de Amazon para el Transit Gateway."
  type        = bool
  default     = true
}

// === ARCHIVO: providers.tf ===
# providers.tf - Configuración del provider de AWS y definición de la versión de Terraform requerida

terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del provider de AWS para la región principal
provider "aws" {
  region = var.regions[0]
  default_tags {
    tags = var.tags
  }
}

# Configuración de providers adicionales para regiones secundarias
provider "aws" {
  alias  = "secondary"
  region = var.regions[1]
  default_tags {
    tags = var.tags
  }
}

# Configuración para habilitar el uso de Transit Gateway entre regiones
provider "aws" {
  alias  = "transit_gateway_peering"
  region = var.regions[0]
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/TransitGatewayPeeringRole"
  }
}

data "aws_caller_identity" "current" {}

# Configuración para habilitar el uso de Direct Connect
provider "aws" {
  alias = "direct_connect"
  region = var.regions[0]
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/DirectConnectRole"
  }
}

# Configuración para habilitar el uso de VPN
provider "aws" {
  alias = "vpn"
  region = var.regions[0]
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/VPNGatewayRole"
  }
}

// === ARCHIVO: modules/networking/variables.tf ===
# modules/networking/variables.tf - Variables específicas para el módulo de networking

# CIDR block para la VPC
variable "vpc_cidr" {
  description = "CIDR block principal para la VPC."
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "El valor proporcionado para vpc_cidr debe ser un CIDR block válido."
  }
}

# Lista de CIDR blocks para subredes públicas
variable "public_subnet_cidrs" {
  description = "Lista de CIDR blocks para subredes públicas."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.public_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en public_subnet_cidrs deben ser válidos."
  }
}

# Lista de CIDR blocks para subredes privadas
variable "private_subnet_cidrs" {
  description = "Lista de CIDR blocks para subredes privadas."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.private_subnet_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en private_subnet_cidrs deben ser válidos."
  }
}

# Lista de Availability Zones para las subredes
variable "availability_zones" {
  description = "Lista de Availability Zones donde se desplegarán las subredes."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Tags para los recursos de networking
variable "tags" {
  description = "Mapa de tags que se aplicarán a los recursos de networking."
  type        = map(string)
  default = {
    Module = "networking"
  }
}

# Habilitar DNS hostnames en la VPC
variable "enable_dns_hostnames" {
  description = "Indica si se habilitan los DNS hostnames en la VPC."
  type        = bool
  default     = true
}

# Habilitar DNS support en la VPC
variable "enable_dns_support" {
  description = "Indica si se habilita el soporte DNS en la VPC."
  type        = bool
  default     = true
}

# Nombre de la VPC
variable "vpc_name" {
  description = "Nombre de la VPC para identificación."
  type        = string
  default     = "main-vpc"
}

# Habilitar NAT Gateway para subredes privadas
variable "enable_nat_gateway" {
  description = "Indica si se habilita NAT Gateway para subredes privadas."
  type        = bool
  default     = true
}

// === ARCHIVO: modules/transit_gateway/variables.tf ===
# modules/transit_gateway/variables.tf - Variables específicas para el módulo de Transit Gateway

# ASN para el Transit Gateway
variable "transit_gateway_asn" {
  description = "Número de sistema autónomo (ASN) para el Transit Gateway. Debe estar en el rango privado (64512-65534)."
  type        = number
  validation {
    condition     = var.transit_gateway_asn >= 64512 && var.transit_gateway_asn <= 65534
    error_message = "El ASN para Transit Gateway debe estar en el rango privado (64512-65534)."
  }
}

# Nombre del Transit Gateway
variable "transit_gateway_name" {
  description = "Nombre del Transit Gateway para identificación."
  type        = string
  default     = "main-transit-gateway"
}

# Habilitar propagación de rutas en Transit Gateway
variable "transit_gateway_enable_route_propagation" {
  description = "Indica si se habilita la propagación de rutas en el Transit Gateway."
  type        = bool
  default     = true
}

# Habilitar DNS support en Transit Gateway
variable "transit_gateway_enable_dns_support" {
  description = "Indica si se habilita el soporte DNS en el Transit Gateway."
  type        = bool
  default     = true
}

# Habilitar Amazon side ASN en Transit Gateway
variable "transit_gateway_enable_amazon_side_asn" {
  description = "Indica si se habilita el ASN en el lado de Amazon para el Transit Gateway."
  type        = bool
  default     = true
}

# Lista de IDs de VPCs para asociar con el Transit Gateway
variable "vpc_attachments" {
  description = "Lista de IDs de VPCs que se asociarán con el Transit Gateway."
  type = list(object({
    vpc_id             = string
    subnet_ids         = list(string)
    route_table_ids    = list(string)
    dns_support        = bool
    ipv6_support       = bool
    appliance_mode_support = bool
  }))
  default = []
}

# Lista de IDs de Transit Gateways para peering
variable "transit_gateway_peering_attachments" {
  description = "Lista de IDs de Transit Gateways para configurar peering."
  type = list(object({
    peer_transit_gateway_id = string
    peer_account_id         = string
    peer_region             = string
    tags                    = map(string)
  }))
  default = []
}

# CIDR blocks permitidos para rutas en Transit Gateway
variable "transit_gateway_route_cidrs" {
  description = "Lista de CIDR blocks permitidos para rutas en el Transit Gateway."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.transit_gateway_route_cidrs : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en transit_gateway_route_cidrs deben ser válidos."
  }
}

# Tags para los recursos del Transit Gateway
variable "tags" {
  description = "Mapa de tags que se aplicarán a los recursos del Transit Gateway."
  type        = map(string)
  default = {
    Module = "transit_gateway"
  }
}

// === ARCHIVO: modules/vpn/variables.tf ===
# modules/vpn/variables.tf - Variables específicas para el módulo de VPN

# Lista de IPs de Customer Gateway
variable "customer_gateway_ips" {
  description = "Lista de IPs públicas de los Customer Gateways para conexiones VPN."
  type        = list(string)
  validation {
    condition     = alltrue([for ip in var.customer_gateway_ips : can(cidrhost("${ip}/32", 0))])
    error_message = "Todas las IPs en customer_gateway_ips deben ser direcciones IP públicas válidas."
  }
}

# CIDR blocks para conexiones VPN
variable "vpn_cidr_blocks" {
  description = "Lista de CIDR blocks para conexiones VPN."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.vpn_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en vpn_cidr_blocks deben ser válidos."
  }
}

# Tipo de dispositivo para Customer Gateway
variable "customer_gateway_device_types" {
  description = "Lista de tipos de dispositivos para los Customer Gateways."
  type        = list(string)
  default     = ["CiscoASA", "JuniperMX"]
}

# Tipo de routing para las conexiones VPN
variable "vpn_routing_type" {
  description = "Tipo de routing para las conexiones VPN (static o dynamic)."
  type        = string
  default     = "dynamic"
  validation {
    condition     = contains(["static", "dynamic"], var.vpn_routing_type)
    error_message = "El tipo de routing debe ser 'static' o 'dynamic'."
  }
}

# Tags para los recursos de VPN
variable "tags" {
  description = "Mapa de tags que se aplicarán a los recursos de VPN."
  type        = map(string)
  default = {
    Module = "vpn"
  }
}

# ID del Transit Gateway para asociar las conexiones VPN
variable "transit_gateway_id" {
  description = "ID del Transit Gateway para asociar las conexiones VPN."
  type        = string
  default     = ""
}

# ID de la VPC para asociar las conexiones VPN
variable "vpc_id" {
  description = "ID de la VPC para asociar las conexiones VPN."
  type        = string
  default     = ""
}

# Lista de IDs de subredes para asociar las conexiones VPN
variable "subnet_ids" {
  description = "Lista de IDs de subredes para asociar las conexiones VPN."
  type        = list(string)
  default     = []
}

# Habilitar aceleración para VPN
variable "enable_vpn_acceleration" {
  description = "Indica si se habilita la aceleración para las conexiones VPN."
  type        = bool
  default     = true
}

# Lista de túneles VPN para configuraciones personalizadas
variable "vpn_tunnels" {
  description = "Lista de configuraciones personalizadas para túneles VPN."
  type = list(object({
    pre_shared_key      = string
    tunnel1_inside_cidr = string
    tunnel2_inside_cidr = string
    tunnel1_preshared_key = string
    tunnel2_preshared_key = string
  }))
  default = []
}

// === ARCHIVO: modules/direct_connect/variables.tf ===
# modules/direct_connect/variables.tf - Variables específicas para el módulo de Direct Connect

# Lista de CIDR blocks para conexiones Direct Connect
variable "direct_connect_cidr_blocks" {
  description = "Lista de CIDR blocks para conexiones Direct Connect."
  type        = list(string)
  validation {
    condition     = alltrue([for cidr in var.direct_connect_cidr_blocks : can(cidrhost(cidr, 0))])
    error_message = "Todos los CIDR blocks en direct_connect_cidr_blocks deben ser válidos."
  }
}

# Nombre de la conexión Direct Connect
variable "direct_connect_connection_name" {
  description = "Nombre de la conexión Direct Connect para identificación."
  type        = string
  default     = "main-direct-connect"
}

# Ancho de banda de la conexión Direct Connect
variable "direct_connect_bandwidth" {
  description = "Ancho de banda de la conexión Direct Connect (ej. 1Gbps, 10Gbps)."
  type        = string
  default     = "1Gbps"
  validation {
    condition     = contains(["50Mbps", "100Mbps", "200Mbps", "300Mbps", "400Mbps", "500Mbps", "1Gbps", "2Gbps", "5Gbps", "10Gbps"], var.direct_connect_bandwidth)
    error_message = "El ancho de banda debe ser uno de los valores soportados (ej. 1Gbps, 10Gbps)."
  }
}

# Location para la conexión Direct Connect
variable "direct_connect_location" {
  description = "Location donde se establecerá la conexión Direct Connect."
  type        = string
  default     = "EqDC2"
}

# ID de la VLAN para la conexión Direct Connect
variable "direct_connect_vlan_id" {
  description = "ID de la VLAN para la conexión Direct Connect."
  type        = number
  default     = 100
  validation {
    condition     = var.direct_connect_vlan_id >= 1 && var.direct_connect_vlan_id <= 4094
    error_message = "El ID de la VLAN debe estar entre 1 y 4094."
  }
}

# Tipo de autenticación para la conexión Direct Connect
variable "direct_connect_authentication_key" {
  description = "Clave de autenticación para la conexión Direct Connect."
  type        = string
  default     = ""
  sensitive   = true
}

# Tags para los recursos de Direct Connect
variable "tags" {
  description = "Mapa de tags que se aplicarán a los recursos de Direct Connect."
  type        = map(string)
  default = {
    Module = "direct_connect"
  }
}

# ID del Transit Gateway para asociar la conexión Direct Connect
variable "transit_gateway_id" {
  description = "ID del Transit Gateway para asociar la conexión Direct Connect."
  type        = string
  default     = ""
}

# ID de la VPC para asociar la conexión Direct Connect
variable "vpc_id" {
  description = "ID de la VPC para asociar la conexión Direct Connect."
  type        = string
  default     = ""
}

# Lista de IDs de subredes para asociar la conexión Direct Connect
variable "subnet_ids" {
  description = "Lista de IDs de subredes para asociar la conexión Direct Connect."
  type        = list(string)
  default     = []
}

# Habilitar propagación de rutas para Direct Connect
variable "enable_direct_connect_route_propagation" {
  description = "Indica si se habilita la propagación de rutas para Direct Connect."
  type        = bool
  default     = true
}

# Lista de conexiones Direct Connect para configuraciones personalizadas
variable "direct_connect_connections" {
  description = "Lista de configuraciones personalizadas para conexiones Direct Connect."
  type = list(object({
    name               = string
    bandwidth          = string
    location           = string
    vlan_id            = number
    authentication_key = string
    tags               = map(string)
  }))
  default = []
}

// === ARCHIVO: modules/nat_gateway/variables.tf ===
variable "vpc_id" {
  description = "ID de la VPC donde se creará el NAT Gateway"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs de las subredes públicas donde se desplegarán los NAT Gateways para alta disponibilidad"
  type        = list(string)
}

variable "allocation_id" {
  description = "ID de la asignación de IP elástica para el NAT Gateway. Si no se proporciona, se creará una nueva"
  type        = string
  default     = null
}

variable "nat_gateway_name" {
  description = "Nombre del NAT Gateway para identificación"
  type        = string
  default     = "nat-gw"
}

variable "connectivity_type" {
  description = "Tipo de conectividad del NAT Gateway. Valores válidos: 'public', 'private'"
  type        = string
  default     = "public"
}

variable "tags" {
  description = "Etiquetas personalizadas para el NAT Gateway"
  type        = map(string)
  default     = {}
}

variable "enable_private_nat" {
  description = "Habilitar NAT Gateway para conectividad saliente desde subredes privadas hacia infraestructura externa"
  type        = bool
  default     = false
}

variable "private_nat_destination" {
  description = "Destino para NAT privado (dirección IP o CIDR destino)"
  type        = string
  default     = null
}

variable "nat_gateway_count" {
  description = "Número de NAT Gateways a crear.通常 se despliega uno por AZ para alta disponibilidad"
  type        = number
  default     = 1
}

// === ARCHIVO: modules/networking/main.tf ===
terraform {
  required_version = ">= 1.5"
}

# ===========================================
# VPC PRINCIPAL
# ===========================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-vpc-${var.vpc_name}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "vpc-main"
    }
  )
}

# ===========================================
# INTERNET GATEWAY
# ===========================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-igw"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "internet-gateway"
    }
  )
}

# ===========================================
# ELASTIC IP PARA NAT GATEWAY
# ===========================================
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? var.nat_gateway_count : 0
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-eip-nat-${count.index}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "nat-gateway-eip"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# ===========================================
# NAT GATEWAY
# ===========================================
resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway ? var.nat_gateway_count : 0
  allocation_id = aws_eip_nat[count.index].id
  subnet_id     = aws_subnet.public[var.nat_subnet_azs[count.index] != null ? index(keys(var.nat_subnet_azs), keys(var.nat_subnet_azs)[count.index]) : count.index].id

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-nat-gw-${count.index}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "nat-gateway"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# ===========================================
# SUBREDES PÚBLICAS
# ===========================================
locals {
  # Calcular subredes públicas basadas en el bloque CIDR de la VPC
  public_subnet cidrs = [for i, az in var.availability_zones : cidrsubnet(var.vpc_cidr, var.subnet_prefix_length, i)]
  
  # Calcular subredes privadas para cada tier
  private_subnet_cidrs = {
    for tier, config in var.private_subnet_tiers :
    tier => [for i, az in var.availability_zones : cidrsubnet(config.cidr_offset, config.subnet_prefix_length, i)]
  }
  
  # Mapear AZs a índices para NAT Gateway
  az_list = var.availability_zones
}

resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-public-subnet-${count.index + 1}-${var.availability_zones[count.index]}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Tier        = "public"
      SubnetType  = "public"
      AZ          = var.availability_zones[count.index]
    }
  )
}

# ===========================================
# SUBREDES PRIVADAS POR TIER
# ===========================================
resource "aws_subnet" "private" {
  # Generar una lista plana de todas las subredes privadas de todos los tiers
  for_each = merge([
    for tier, config in var.private_subnet_tiers :
    {
      for i, az in var.availability_zones :
      "${tier}-${i}" => {
        tier           = tier
        cidr           = config.cidr_offsets[count.index]
        az             = az
        additional_tags = config.additional_tags
      }
    }
  ]...)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(
    var.tags,
    each.value.additional_tags,
    {
      Name        = "${var.environment}-private-${each.value.tier}-subnet-${index(var.availability_zones, each.value.az) + 1}-${each.value.az}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Tier        = each.value.tier
      SubnetType  = "private"
      AZ          = each.value.az
    }
  )
}

# ===========================================
# TABLAS DE RUTAS PÚBLICAS
# ===========================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-public-rt"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "public-route-table"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ===========================================
# TABLAS DE RUTAS PRIVADAS
# ===========================================
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_tiers)
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  }

  # Ruta hacia Transit Gateway si está habilitado
  dynamic "route" {
    for_each = var.transit_gateway_id != null ? [1] : []
    content {
      cidr_block         = var.transit_gateway_route
      transit_gateway_id = var.transit_gateway_id
    }
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-private-${keys(var.private_subnet_tiers)[count.index]}-rt"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "private-route-table"
      Tier        = keys(var.private_subnet_tiers)[count.index]
    }
  )
}

# ===========================================
# ASOCIACIONES DE RUTAS PRIVADAS
# ===========================================
resource "aws_route_table_association" "private" {
  # Crear asociación para cada subred privada
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[index(keys(var.private_subnet_tiers), each.value.tags["Tier"])].id
}

# ===========================================
# SECURITY GROUPS BÁSICOS
# ===========================================
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Security group por defecto para la VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Permitir todo el tráfico entrante dentro de la VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Permitir todo el tráfico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-default-sg"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )
}

// === ARCHIVO: modules/networking/outputs.tf ===
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = aws_vpc.main.cidr_block
}

output "vpc_name" {
  description = "Nombre de la VPC"
  value       = aws_vpc.main.tags["Name"]
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = aws_subnet.public[*].cidr_block
}

output "public_subnet_azs" {
  description = "Zonas de disponibilidad de las subredes públicas"
  value       = aws_subnet.public[*].availability_zone
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = { for k, v in aws_subnet.private : k => v.cidr_block }
}

output "private_subnet_azs" {
  description = "Zonas de disponibilidad de las subredes privadas"
  value       = { for k, v in aws_subnet.private : k => v.availability_zone }
}

output "private_subnet_ids_by_tier" {
  description = "IDs de subredes privadas agrupadas por tier"
  value = {
    for k, v in aws_subnet.private :
    v.tags["Tier"] => concat(
      [for subnet in aws_subnet.private : subnet.id if subnet.tags["Tier"] == v.tags["Tier"]],
    )
  }
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas por tier"
  value       = aws_route_table.private[*].id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_ips" {
  description = "IPs elásticas asignadas a los NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "default_security_group_id" {
  description = "ID del security group por defecto"
  value       = aws_security_group.default.id
}

output "vpc_attributes" {
  description = "Atributos completos de la VPC"
  value = {
    id                    = aws_vpc.main.id
    cidr_block            = aws_vpc.main.cidr_block
    enable_dns_hostnames = aws_vpc.main.enable_dns_hostnames
    enable_dns_support   = aws_vpc.main.enable_dns_support
    instance_tenancy      = aws_vpc.main.instance_tenancy
    default_security_group = aws_security_group.default.id
    igw_id                = aws_internet_gateway.main.id
  }
}


// === ARCHIVO: modules/transit_gateway/main.tf ===
resource "aws_ec2_transit_gateway" "main" {
  amazon_asn               = var.amazon_asn
  auto_accept_shared_attachments = var.auto_accept_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  description               = var.description
  dns_support              = var.dns_support
  multicast_support        = var.multicast_support
  vpn_ecmp_support         = var.vpn_ecmp_support

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-tgw"
    }
  )
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachments" {
  count = length(var.vpc_attachments)

  subnet_ids         = var.vpc_attachments[count.index].subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = var.vpc_attachments[count.index].vpc_id

  dns_support        = var.vpc_attachments[count.index].enable_dns_support != null ? var.vpc_attachments[count.index].enable_dns_support : "enable"
  ipv6_support       = var.vpc_attachments[count.index].enable_ipv6_support != null ? var.vpc_attachments[count.index].enable_ipv6_support : "disable"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-attachment-${var.vpc_attachments[count.index].vpc_name}"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table" "route_tables" {
  count = length(var.custom_route_tables) > 0 ? length(var.custom_route_tables) : 0

  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-rt-${var.custom_route_tables[count.index].name}"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "associations" {
  count = length(var.vpc_attachments)

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[count.index].id
  transit_gateway_route_table_id = length(var.custom_route_tables) > 0 ? aws_ec2_transit_gateway_route_table.route_tables[0].id : aws_ec2_transit_gateway.main.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "propagations" {
  count = length(var.vpc_attachments)

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[count.index].id
  transit_gateway_route_table_id = length(var.custom_route_tables) > 0 ? aws_ec2_transit_gateway_route_table.route_tables[0].id : aws_ec2_transit_gateway.main.propagation_default_route_table_id
}

resource "aws_ec2_transit_gateway_route" "static_routes" {
  count = length(var.static_routes)

  destination_cidr_block         = var.static_routes[count.index].destination_cidr_block
  transit_gateway_attachment_id  = var.static_routes[count.index].attachment_id != null ? var.static_routes[count.index].attachment_id : aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[0].id
  transit_gateway_route_table_id = length(var.custom_route_tables) > 0 ? aws_ec2_transit_gateway_route_table.route_tables[0].id : aws_ec2_transit_gateway.main.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_peering_attachment" "peering" {
  count = var.peering_config != null ? 1 : 0

  acceptor_account_id         = var.peering_config.acceptor_account_id
  acceptor_transit_gateway_id = var.peering_config.acceptor_tgw_id
  provider_account_id         = var.peering_config.provider_account_id
  requester_transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-peering"
    }
  )
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "peering_accepter" {
  count = var.peering_accepter_config != null ? 1 : 0

  transit_gateway_attachment_id = var.peering_accepter_config.attachment_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-peering-accepter"
    }
  )
}

resource "aws_ec2_transit_gateway_connect" "connect" {
  count = length(var.connect_attachments)

  transport_attachment_id = var.connect_attachments[count.index].transport_attachment_id
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
  protocol               = var.connect_attachments[count.index].protocol

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-connect-${count.index}"
    }
  )
}

// === ARCHIVO: modules/transit_gateway/outputs.tf ===
output "transit_gateway_id" {
  description = "ID del Transit Gateway"
  value       = aws_ec2_transit_gateway.main.id
}

output "transit_gateway_arn" {
  description = "ARN del Transit Gateway"
  value       = aws_ec2_transit_gateway.main.arn
}

output "transit_gateway_owner_account_id" {
  description = "ID de la cuenta dueña del Transit Gateway"
  value       = aws_ec2_transit_gateway.main.owner_id
}

output "association_default_route_table_id" {
  description = "ID de la tabla de rutas de asociación por defecto"
  value       = aws_ec2_transit_gateway.main.association_default_route_table_id
}

output "propagation_default_route_table_id" {
  description = "ID de la tabla de rutas de propagación por defecto"
  value       = aws_ec2_transit_gateway.main.propagation_default_route_table_id
}

output "vpc_attachment_ids" {
  description = "Lista de IDs de los attachments de VPC"
  value       = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[*].id
}

output "vpc_attachment_vpc_ids" {
  description = "Lista de IDs de las VPCs conectadas al Transit Gateway"
  value       = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[*].vpc_id
}

output "custom_route_table_ids" {
  description = "Lista de IDs de las tablas de rutas personalizadas"
  value       = aws_ec2_transit_gateway_route_table.route_tables[*].id
}

output "peering_attachment_id" {
  description = "ID del attachment de peering (si existe)"
  value       = length(aws_ec2_transit_gateway_peering_attachment.peering) > 0 ? aws_ec2_transit_gateway_peering_attachment.peering[0].id : null
}

output "connect_attachment_ids" {
  description = "Lista de IDs de los attachments de Connect"
  value       = aws_ec2_transit_gateway_connect.connect[*].id
}

// === ARCHIVO: modules/vpn/main.tf ===
resource "aws_customer_gateway" "customer_gateways" {
  count = length(var.customer_gateways)

  bgp_asn    = var.customer_gateways[count.index].bgp_asn
  ip_address = var.customer_gateways[count.index].ip_address
  type       = var.customer_gateways[count.index].type

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-cgw-${var.customer_gateways[count.index].name}"
    }
  )
}

resource "aws_vpn_connection" "vpn_connections" {
  count = length(var.vpn_connections)

  customer_gateway_id = var.vpn_connections[count.index].customer_gateway_id
  type                = var.vpn_connections[count.index].type
  static_routes_only  = var.vpn_connections[count.index].static_routes_only

  tunnel_inside_ip_version = var.vpn_connections[count.index].tunnel_inside_ip_version
  tunnel1_preshared_key    = var.vpn_connections[count.index].tunnel1_preshared_key
  tunnel1_inside_cidr      = var.vpn_connections[count.index].tunnel1_inside_cidr
  tunnel2_preshared_key    = var.vpn_connections[count.index].tunnel2_preshared_key
  tunnel2_inside_cidr      = var.vpn_connections[count.index].tunnel2_inside_cidr

  enable_acceleration         = var.vpn_connections[count.index].enable_acceleration
  local_ipv4_network_cidr     = var.vpn_connections[count.index].local_ipv4_network_cidr
  remote_ipv4_network_cidr    = var.vpn_connections[count.index].remote_ipv4_network_cidr

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpn-${var.vpn_connections[count.index].name}"
    }
  )
}

resource "aws_vpn_connection_route" "static_routes" {
  count = length(var.vpn_static_routes)

  destination_cidr_block = var.vpn_static_routes[count.index].destination_cidr_block
  vpn_connection_id      = var.vpn_static_routes[count.index].vpn_connection_id
}

resource "aws_customer_gateway" "dynamic_customer_gateway" {
  count = var.dynamic_routing_customer_gateway != null ? 1 : 0

  bgp_asn    = var.dynamic_routing_customer_gateway.bgp_asn
  ip_address = var.dynamic_routing_customer_gateway.ip_address
  type       = "ipsec.1"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-cgw-dynamic"
    }
  )
}

resource "aws_vpn_connection" "dynamic_vpn_connection" {
  count = var.dynamic_routing_config != null ? 1 : 0

  customer_gateway_id = aws_customer_gateway.dynamic_customer_gateway[0].id
  type                = "ipsec.1"
  static_routes_only  = false

  dynamic_routing_config {
    routing_type = var.dynamic_routing_config.routing_type
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpn-dynamic"
    }
  )
}

resource "aws_ec2_transit_gateway_vpn_attachment" "tgw_vpn_attachment" {
  count = var.attach_to_transit_gateway ? length(var.vpn_connections) : 0

  transit_gateway_id = var.transit_gateway_id
  vpn_connection_id  = aws_vpn_connection.vpn_connections[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-tgw-vpn-${count.index}"
    }
  )
}

resource "aws_vpn_connection" "redundant_vpn" {
  count = var.redundant_vpn_config != null ? 1 : 0

  customer_gateway_id = var.redundant_vpn_config.customer_gateway_id
  type                = "ipsec.1"
  static_routes_only  = var.redundant_vpn_config.static_routes_only

  tunnel_inside_ip_version = "ipv4"
  tunnel1_preshared_key    = var.redundant_vpn_config.tunnel1_preshared_key
  tunnel1_inside_cidr      = var.redundant_vpn_config.tunnel1_inside_cidr
  tunnel2_preshared_key    = var.redundant_vpn_config.tunnel2_preshared_key
  tunnel2_inside_cidr      = var.redundant_vpn_config.tunnel2_inside_cidr

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpn-redundant"
    }
  )
}

resource "aws_vpn_connection_metric" "vpn_metrics" {
  count = length(aws_vpn_connection.vpn_connections)

  vpn_connection_id = aws_vpn_connection.vpn_connections[count.index].id
}


// === ARCHIVO: modules/vpn/outputs.tf ===
output "vpn_connection_ids" {
  description = "Lista de IDs de las conexiones VPN creadas"
  value       = aws_vpn_connection.main[*].id
}

output "vpn_connection_id_primary" {
  description = "ID de la conexión VPN primaria"
  value       = aws_vpn_connection.main[0].id
}

output "vpn_connection_id_secondary" {
  description = "ID de la conexión VPN secundaria para alta disponibilidad"
  value       = length(aws_vpn_connection.main) > 1 ? aws_vpn_connection.main[1].id : ""
}

output "vpn_tunnel_external_ip_primary" {
  description = "IP externa del túnel primario de la primera conexión VPN"
  value       = aws_vpn_connection.main[0].tunnel1_inside_ip_address
}

output "vpn_tunnel_external_ip_secondary" {
  description = "IP externa del túnel secundario de la primera conexión VPN"
  value       = aws_vpn_connection.main[0].tunnel2_inside_ip_address
}

output "vpn_customer_gateway_ip_primary" {
  description = "IP del Customer Gateway para la conexión primaria"
  value       = aws_customer_gateway.main[0].ip_address
}

output "vpn_customer_gateway_ip_secondary" {
  description = "IP del Customer Gateway para la conexión secundaria"
  value       = length(aws_customer_gateway.main) > 1 ? aws_customer_gateway.main[1].ip_address : ""
}

output "vpn_customer_gateway_arns" {
  description = "ARNs de los Customer Gateways creados"
  value       = aws_customer_gateway.main[*].arn
}

output "vpn_transit_gateway_attachment_ids" {
  description = "IDs de los attachments al Transit Gateway"
  value       = aws_vpn_connection.main[*].transit_gateway_attachment_id
}

output "vpn_routing_table_id" {
  description = "ID de la tabla de rutas asociada a las conexiones VPN"
  value       = length(aws_vpn_connection.main) > 0 ? aws_vpn_connection.main[0].routes[0].destination_cidr_block_configured : ""
}

output "vpn_status" {
  description = "Estado de las conexiones VPN"
  value       = { for conn in aws_vpn_connection.main : conn.id => conn.state }
}

output "vpn_tags" {
  description = "Tags aplicados a las conexiones VPN"
  value       = { for conn in aws_vpn_connection.main : conn.id => conn.tags }
}
// === ARCHIVO: modules/direct_connect/main.tf ===
locals {
  dx_tags = merge(
    var.common_tags,
    var.dx_tags,
    {
      "Environment" = var.environment
      "ManagedBy"   = "Terraform"
    }
  )

  vlan_range = range(var.first_vlan, var.first_vlan + var.connection_count * 1000)

  virtual_interface_names = var.virtual_interface_names != null ? var.virtual_interface_names : [for i in range(var.connection_count) : "${var.environment}-vif-${i}"]
}

resource "aws_dx_connection" "main" {
  count = var.connection_count

  name      = "${var.environment}-dx-connection-${count.index}"
  location  = var.dx_location
  bandwidth = var.bandwidth
  provider  = var.aws_provider

  encryption_mode = var.encryption_mode

  tags = merge(local.dx_tags, {
    "Name" = "${var.environment}-dx-${count.index}"
  })

  timeouts {
    create = var.connection_timeout
    delete = var.connection_timeout
    update = var.connection_timeout
  }
}

resource "aws_dx_private_virtual_interface" "private_vif" {
  count = var.create_private_vif ? var.connection_count : 0

  name                  = "${local.virtual_interface_names[count.index]}-private"
  connection_id         = aws_dx_connection.main[count.index].id
  vlan                  = local.vlan_range[count.index]
  address_family        = "ipv4"
  bgp_asn               = var.bgp_asn
  customer_address      = var.customer_address
  mtu                   = var.private_vif_mtu
  virtual_interface_id  = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-private-vif-${count.index}"
    "Type"        = "Private"
    "Environment" = var.environment
  })

  depends_on = [aws_dx_connection.main]
}

resource "aws_dx_public_virtual_interface" "public_vif" {
  count = var.create_public_vif ? var.connection_count : 0

  name                  = "${local.virtual_interface_names[count.index]}-public"
  connection_id         = aws_dx_connection.main[count.index].id
  vlan                  = local.vlan_range[count.index + 500]
  address_family        = "ipv4"
  bgp_asn               = var.bgp_asn
  customer_address      = var.customer_address
  mtu                   = var.public_vif_mtu
  virtual_interface_id  = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-public-vif-${count.index}"
    "Type"        = "Public"
    "Environment" = var.environment
  })

  depends_on = [aws_dx_connection.main]
}

resource "aws_dx_hosted_transit_virtual_interface" "hosted_transit_vif" {
  count = var.create_hosted_transit_vif ? 1 : 0

  name                 = "${var.environment}-hosted-transit-vif"
  connection_id        = var.hosted_connection_id
  vlan                 = var.hosted_vlan
  address_family       = "ipv4"
  bgp_asn              = var.bgp_asn
  customer_address     = var.customer_address
  mtu                  = var.hosted_vif_mtu
  owner_account_id     = var.hosted_owner_account_id
  amazon_address       = var.amazon_address
  virtual_interface_id = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-hosted-transit-vif"
    "Type"        = "HostedTransit"
    "Environment" = var.environment
  })
}

resource "aws_dx_hosted_private_virtual_interface" "hosted_private_vif" {
  count = var.create_hosted_private_vif ? 1 : 0

  name                 = "${var.environment}-hosted-private-vif"
  connection_id        = var.hosted_connection_id
  vlan                 = var.hosted_vlan
  address_family       = "ipv4"
  bgp_asn              = var.bgp_asn
  customer_address     = var.customer_address
  mtu                  = var.hosted_vif_mtu
  owner_account_id     = var.hosted_owner_account_id
  amazon_address       = var.amazon_address
  virtual_interface_id = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-hosted-private-vif"
    "Type"        = "HostedPrivate"
    "Environment" = var.environment
  })
}

resource "aws_dx_hosted_public_virtual_interface" "hosted_public_vif" {
  count = var.create_hosted_public_vif ? 1 : 0

  name                 = "${var.environment}-hosted-public-vif"
  connection_id        = var.hosted_connection_id
  vlan                 = var.hosted_vlan
  address_family       = "ipv4"
  bgp_asn              = var.bgp_asn
  customer_address     = var.customer_address
  mtu                  = var.hosted_vif_mtu
  owner_account_id     = var.hosted_owner_account_id
  amazon_address       = var.amazon_address
  virtual_interface_id = var.existing_virtual_interface_id

  route_filter_prefixes = var.advertise_prefixes

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-hosted-public-vif"
    "Type"        = "HostedPublic"
    "Environment" = var.environment
  })
}

resource "aws_dx_lag" "dx_lag" {
  count = var.create_lag ? 1 : 0

  name                  = "${var.environment}-dx-lag"
  connections_bandwidth = var.lag_bandwidth
  location              = var.dx_location
  provider              = var.aws_provider
  number_of_connections = var.lag_connection_count
  force_destroy         = var.lag_force_destroy

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-dx-lag"
    "Type"        = "LAG"
    "Environment" = var.environment
  })

  timeouts {
    create = var.connection_timeout
    delete = var.connection_timeout
  }
}

resource "aws_dx_connection_association" "lag_association" {
  count = var.create_lag && var.lag_associate_connection_count > 0 ? var.lag_associate_connection_count : 0

  virtual_interface_id = var.create_private_vif ? aws_dx_private_virtual_interface.private_vif[count.index].id : aws_dx_public_virtual_interface.public_vif[count.index].id
  connection_id        = aws_dx_lag.dx_lag[0].id
}
// === ARCHIVO: modules/direct_connect/outputs.tf ===
output "connection_ids" {
  description = "Lista de IDs de las conexiones Direct Connect creadas"
  value       = aws_dx_connection.main[*].id
}

output "connection_id_primary" {
  description = "ID de la conexión Direct Connect primaria"
  value       = aws_dx_connection.main[0].id
}

output "connection_arns" {
  description = "ARNs de las conexiones Direct Connect"
  value       = aws_dx_connection.main[*].arn
}

output "connection_state" {
  description = "Estado de las conexiones Direct Connect"
  value       = { for conn in aws_dx_connection.main : conn.id => conn.state }
}

output "private_virtual_interface_ids" {
  description = "IDs de los Virtual Interfaces privados"
  value       = aws_dx_private_virtual_interface.private_vif[*].id
}

output "private_virtual_interface_id_primary" {
  description = "ID del Virtual Interface privado primario"
  value       = length(aws_dx_private_virtual_interface.private_vif) > 0 ? aws_dx_private_virtual_interface.private_vif[0].id : ""
}

output "private_virtual_interface_arns" {
  description = "ARNs de los Virtual Interfaces privados"
  value       = aws_dx_private_virtual_interface.private_vif[*].arn
}

output "private_virtual_interface_state" {
  description = "Estado de los Virtual Interfaces privados"
  value       = { for vif in aws_dx_private_virtual_interface.private_vif : vif.id => vif.state }
}

output "public_virtual_interface_ids" {
  description = "IDs de los Virtual Interfaces públicos"
  value       = aws_dx_public_virtual_interface.public_vif[*].id
}

output "public_virtual_interface_id_primary" {
  description = "ID del Virtual Interface público primario"
  value       = length(aws_dx_public_virtual_interface.public_vif) > 0 ? aws_dx_public_virtual_interface.public_vif[0].id : ""
}

output "public_virtual_interface_arns" {
  description = "ARNs de los Virtual Interfaces públicos"
  value       = aws_dx_public_virtual_interface.public_vif[*].arn
}

output "public_virtual_interface_state" {
  description = "Estado de los Virtual Interfaces públicos"
  value       = { for vif in aws_dx_public_virtual_interface.public_vif : vif.id => vif.state }
}

output "hosted_transit_virtual_interface_id" {
  description = "ID del Virtual Interface de tránsito hospedado"
  value       = length(aws_dx_hosted_transit_virtual_interface.hosted_transit_vif) > 0 ? aws_dx_hosted_transit_virtual_interface.hosted_transit_vif[0].id : ""
}

output "hosted_private_virtual_interface_id" {
  description = "ID del Virtual Interface privado hospedado"
  value       = length(aws_dx_hosted_private_virtual_interface.hosted_private_vif) > 0 ? aws_dx_hosted_private_virtual_interface.hosted_private_vif[0].id : ""
}

output "hosted_public_virtual_interface_id" {
  description = "ID del Virtual Interface público hospedado"
  value       = length(aws_dx_hosted_public_virtual_interface.hosted_public_vif) > 0 ? aws_dx_hosted_public_virtual_interface.hosted_public_vif[0].id : ""
}

output "lag_id" {
  description = "ID del LAG (Link Aggregation Group) de Direct Connect"
  value       = length(aws_dx_lag.dx_lag) > 0 ? aws_dx_lag.dx_lag[0].id : ""
}

output "lag_arn" {
  description = "ARN del LAG de Direct Connect"
  value       = length(aws_dx_lag.dx_lag) > 0 ? aws_dx_lag.dx_lag[0].arn : ""
}

output "lag_state" {
  description = "Estado del LAG de Direct Connect"
  value       = length(aws_dx_lag.dx_lag) > 0 ? aws_dx_lag.dx_lag[0].state : ""
}

output "all_virtual_interface_ids" {
  description = "Todos los IDs de Virtual Interfaces (privados, públicos y hospedados)"
  value       = concat(
    aws_dx_private_virtual_interface.private_vif[*].id,
    aws_dx_public_virtual_interface.public_vif[*].id,
    aws_dx_hosted_transit_virtual_interface.hosted_transit_vif[*].id,
    aws_dx_hosted_private_virtual_interface.hosted_private_vif[*].id,
    aws_dx_hosted_public_virtual_interface.hosted_public_vif[*].id
  )
}

output "connection_details" {
  description = "Detalles completos de las conexiones Direct Connect"
  value = [for conn in aws_dx_connection.main : {
    id         = conn.id
    name       = conn.name
    location   = conn.location
    bandwidth  = conn.bandwidth
    state      = conn.state
    arn        = conn.arn
    tags       = conn.tags
  }]
}


// === ARCHIVO: modules/nat_gateway/main.tf ===
# --------------------------------------------------------------
# Módulo de NAT Gateway para conectividad de salida
# Proporciona NAT para instancias en subredes privadas hacia internet
# Implementa alta disponibilidad mediante NAT Gateways por AZ
# --------------------------------------------------------------

# Asignación de IP elástica para el NAT Gateway
# La EIP persiste incluso si el NAT Gateway se reemplaza
resource "aws_eip" "nat" {
  for_each = toset(var.availability_zones)

  domain = "vpc"
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.naming_prefix}-eip-${each.value}"
      Type        = "nat-gateway-eip"
      Environment = var.environment
      Component   = "networking"
      ManagedBy   = "terraform"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# NAT Gateway principal en cada zona de disponibilidad
# Proporciona conectividad saliente para subredes privadas
# Alta disponibilidad: un NAT Gateway por AZ evita punto único de fallo
resource "aws_nat_gateway" "main" {
  for_each = toset(var.availability_zones)

  allocation_id = aws_eip.nat[each.value].id
  subnet_id     = var.public_subnet_ids[each.value]

  tags = merge(
    var.common_tags,
    {
      Name             = "${var.naming_prefix}-nat-${each.value}"
      Type             = "nat-gateway"
      Environment      = var.environment
      Component        = "networking"
      AvailabilityZone = each.value
      ManagedBy        = "terraform"
    }
  )

  depends_on = [aws_internet_gateway.main]

  lifecycle {
    create_before_destroy = true
  }
}

# Tabla de enrutamiento para subredes privadas
# Todo el tráfico destined a internet (0.0.0.0/0) se dirige al NAT Gateway
# El NAT Gateway traduce la IP origen privada a IP pública del NAT
resource "aws_route_table" "private" {
  for_each = toset(var.availability_zones)

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[each.value].id
  }

  tags = merge(
    var.common_tags,
    {
      Name             = "${var.naming_prefix}-rt-private-${each.value}"
      Type             = "private-route-table"
      Environment      = var.environment
      Component        = "networking"
      AvailabilityZone = each.value
      ManagedBy        = "terraform"
    }
  )
}

# Asociación de subredes privadas con su tabla de rutas
# Cada subred privada en una AZ específica usa el NAT Gateway de esa AZ
# Optimización de tráfico: evita tráfico cross-AZ innecesario
resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.private[each.key].id
}

# Internet Gateway requerido para NAT Gateway
# Proporciona conectividad hacia internet desde la VPC
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.naming_prefix}-igw"
      Type        = "internet-gateway"
      Environment = var.environment
      Component   = "networking"
      ManagedBy   = "terraform"
    }
  )
}

# Ruta pública en tabla de rutas pública para tráfico internet
# Permite que subredes públicas tengan acceso directo a internet
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.naming_prefix}-rt-public"
      Type        = "public-route-table"
      Environment = var.environment
      Component   = "networking"
      ManagedBy   = "terraform"
    }
  )
}

# Asociación de subredes públicas con tabla de rutas pública
resource "aws_route_table_association" "public" {
  for_each = var.public_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

// === ARCHIVO: modules/nat_gateway/outputs.tf ===
# --------------------------------------------------------------
# Outputs del módulo de NAT Gateway
# Expone información necesaria para otros módulos y recursos
# --------------------------------------------------------------

# ID del NAT Gateway para referencia en otras partes del código
output "nat_gateway_ids" {
  description = "Map de IDs de NAT Gateway por zona de disponibilidad"
  value       = { for az, nat in aws_nat_gateway.main : az => nat.id }
}

# IDs de las IPs elásticas asociadas a los NAT Gateways
output "eip_allocation_ids" {
  description = "Map de IDs de asignación de EIP por zona de disponibilidad"
  value       = { for az, eip in aws_eip.nat : az => eip.id }
}

# IDs de las tablas de rutas privadas
output "private_route_table_ids" {
  description = "Map de IDs de tablas de rutas privadas por zona de disponibilidad"
  value       = { for az, rt in aws_route_table.private : az => rt.id }
}

# ID de la tabla de rutas pública
output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

# ID del Internet Gateway
output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# ARNs de los NAT Gateways para políticas IAM y monitoreo
output "nat_gateway_arns" {
  description = "Map de ARNs de NAT Gateway por zona de disponibilidad"
  value       = { for az, nat in aws_nat_gateway.main : az => nat.arn }
}

# IPs públicas asignadas a los NAT Gateways
output "nat_gateway_public_ips" {
  description = "Map de IPs públicas de NAT Gateway por zona de disponibilidad"
  value       = { for az, eip in aws_eip.nat : az => eip.public_ip }
}

# Subredes públicas donde están desplegados los NAT Gateways
output "nat_gateway_subnet_ids" {
  description = "Map de IDs de subredes públicas usadas por NAT Gateway"
  value       = var.public_subnet_ids
}

# IDs de las tablas de enrutamiento privadas para asociación con subredes
output "all_private_route_tables" {
  description = "Lista completa de IDs de tablas de rutas privadas"
  value       = values(aws_route_table.private)[*].id
}


// === ARCHIVO: main.tf ===
# ==============================================================================
# Configuración Principal de Networking - Landing Zone Multi-Cuenta
# ==============================================================================
# Este archivo orquesta la creación de los componentes principales de red:
# VPC principal, subredes, Transit Gateway, VPN redundantes, Direct Connect
# y NAT Gateway para salida a Internet.
# ==============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==============================================================================
# MÓDULO: VPC PRINCIPAL Y SUBNETS
# ==============================================================================
# Crea la VPC principal con su esquema de direccionamiento CIDR.
# Genera subredes públicas y privadas en múltiples AZs para alta disponibilidad.
# ==============================================================================

module "networking" {
  source = "./modules/networking"

  # Identificadores y etiquetas
  environment           = var.environment
  project_name          = var.project_name
  tags                  = var.common_tags

  # Configuración de CIDR
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs

  # Configuración de disponibilidad
  availability_zones    = var.availability_zones
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway

  # DNS y opciones de VPC
  enable_dns_hostnames = true
  enable_dns_support   = true

  providers = {
    aws = aws
  }
}

# ==============================================================================
# MÓDULO: TRANSIT GATEWAY
# ==============================================================================
# Crea un Transit Gateway para interconectar VPCs, conexiones VPN y Direct Connect.
# Configura attachments para cada VPC y permite enrutamiento centralizado.
# ==============================================================================

module "transit_gateway" {
  source = "./modules/transit_gateway"

  # Identificadores
  environment  = var.environment
  project_name = var.project_name
  tags         = var.common_tags

  # Configuración del Transit Gateway
  tgw_asn                 = var.tgw_asn
  enable_auto_route       = var.tgw_auto_route
  enable_dns_support      = true
  enable_ecmp             = var.enable_ecmp
  default_route_table_association = true
  default_route_table_propagation = true

  # Tags específicos para categorización
  tgw_category = "core-networking"

  providers = {
    aws = aws
  }
}

# ==============================================================================
# ASOCIACIONES DEL TRANSIT GATEWAY CON VPCS
# ==============================================================================
# Asocia la VPC principal y otras VPCs al Transit Gateway para permitir
# comunicación entre ellas a través del núcleo de red.
# ==============================================================================

resource "aws_ec2_transit_gateway_vpc_attachment" "main_vpc_attachment" {
  provider = aws

  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids

  options {
    dns_support                   = "enable"
    ipv6_support                  = "disable"
    appliance_mode_support        = "disable"
    security_group_referencing_support = "enable"
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-tgw-attachment-main-vpc"
    Description = "Attachment de VPC principal al Transit Gateway"
    Component   = "transit-gateway"
    Environment = var.environment
  })
}

# Attachment para VPCs adicionales definidas en el mapa de attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "additional_vpcs" {
  provider = aws

  for_each = var.additional_vpc_attachments

  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  options {
    dns_support                   = "enable"
    ipv6_support                  = "disable"
    appliance_mode_support        = "disable"
    security_group_referencing_support = "enable"
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-tgw-attachment-${each.key}"
    Description = "Attachment de ${each.key} al Transit Gateway"
    Component   = "transit-gateway"
    Environment = var.environment
  })
}

# ==============================================================================
# MÓDULO: VPN REDUNDANTES (ALTA DISPONIBILIDAD)
# ==============================================================================
# Crea conexiones VPN redundantes hacia on-premise mediante dos túneles.
# Implementa VPN primaria y secundaria para resiliencia.
# ==============================================================================

module "vpn" {
  source = "./modules/vpn"

  # Identificadores
  environment  = var.environment
  project_name = var.project_name
  tags         = var.common_tags

  # Conexión al Transit Gateway
  transit_gateway_id = module.transit_gateway.transit_gateway_id

  # Configuración de VPN
  customer_gateway_ip   = var.customer_gateway_ip
  customer_gateway_bgp_asn = var.customer_gateway_bgp_asn

  # Habilitar redundancia
  enable_redundancy = true
  vpn_type          = "ipsec.1"

  providers = {
    aws = aws
  }
}

# ==============================================================================
# MÓDULO: DIRECT CONNECT
# ==============================================================================
# Configura conexión dedicada hacia on-premise mediante AWS Direct Connect.
# Soporta múltiples conexiones para redundancia y mayor ancho de banda.
# ==============================================================================

module "direct_connect" {
  source = "./modules/direct_connect"

  # Identificadores
  environment  = var.environment
  project_name = var.project_name
  tags         = var.common_tags

  # Conexión al Transit Gateway
  transit_gateway_id = module.transit_gateway.transit_gateway_id

  # Configuración de Direct Connect
  dx_connection_name     = var.dx_connection_name
  dx_bandwidth           = var.dx_bandwidth
  dx_location            = var.dx_location
  dx_vlan                = var.dx_vlan
  enable_private_virtual_interface = true
  enable_public_virtual_interface  = false

  providers = {
    aws = aws
  }
}

# ==============================================================================
# RUTAS DEL TRANSIT GATEWAY
# ==============================================================================
# Configura las tablas de rutas del Transit Gateway para dirigir tráfico
# entre VPCs, VPN y Direct Connect de manera controlada.
# ==============================================================================

resource "aws_ec2_transit_gateway_route" "vpc_to_vpn" {
  provider = aws

  transit_gateway_route_table_id = module.transit_gateway.default_route_table_id
  destination_cidr_block         = var.on_premise_cidr
  transit_gateway_attachment_id  = module.vpn.vpn_attachment_id
}

resource "aws_ec2_transit_gateway_route" "vpc_to_direct_connect" {
  provider = aws

  for_each = toset(var.on_premise_networks)

  transit_gateway_route_table_id = module.transit_gateway.default_route_table_id
  destination_cidr_block         = each.value
  transit_gateway_attachment_id  = module.direct_connect.dx_gateway_attachment_id
}

resource "aws_ec2_transit_gateway_route" "vpc_to_additional_vpcs" {
  provider = aws

  for_each = aws_ec2_transit_gateway_vpc_attachment.additional_vpcs

  transit_gateway_route_table_id = module.transit_gateway.default_route_table_id
  destination_cidr_block         = var.additional_vpc_attachments[each.key].cidr
  transit_gateway_attachment_id  = each.value.id
}

# ==============================================================================
# RUTAS DE LA VPC PRINCIPAL
# ==============================================================================
# Configura rutas en la tabla de rutas de la VPC para dirigir tráfico
# hacia el Transit Gateway y otras redes conectadas.
# ==============================================================================

resource "aws_route" "vpc_to_transit_gateway" {
  provider = aws

  route_table_id         = module.networking.private_route_table_id
  destination_cidr_block = var.transit_gateway_route_cidr
  transit_gateway_id     = module.transit_gateway.transit_gateway_id
}

resource "aws_route" "vpc_to_on_premise" {
  provider = aws

  route_table_id         = module.networking.private_route_table_id
  destination_cidr_block = var.on_premise_cidr
  transit_gateway_id     = module.transit_gateway.transit_gateway_id
}

# ==============================================================================
# TABLA DE RUTAS PÚBLICA PARA NAT GATEWAY
# ==============================================================================
# Permite que las instancias en subredes privadas salgan a Internet
# a través del NAT Gateway.
# ==============================================================================

resource "aws_route" "private_to_nat_gateway" {
  provider = aws

  route_table_id         = module.networking.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.networking.nat_gateway_id
}

# ==============================================================================
# SECURITY GROUPS DE RED
# ==============================================================================
# Grupos de seguridad para gestión y acceso a componentes de red.
# ==============================================================================

resource "aws_security_group" "network_management" {
  provider = aws

  name        = "${var.project_name}-${var.environment}-network-management"
  description = "Security group para acceso de gestión a componentes de red"
  vpc_id      = module.networking.vpc_id

  ingress {
    description = "SSH desde red de gestión"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.management_cidr]
  }

  ingress {
    description = "HTTPS desde red de gestión"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.management_cidr]
  }

  egress {
    description = "Salida a Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-sg-network-mgmt"
    Component   = "security-group"
    Environment = var.environment
  })
}

resource "aws_security_group" "inter_vpc" {
  provider = aws

  name        = "${var.project_name}-${var.environment}-inter-vpc"
  description = "Security group para comunicación entre VPCs"
  vpc_id      = module.networking.vpc_id

  ingress {
    description = "Todo el tráfico desde VPCs conectadas"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Salida a Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-sg-inter-vpc"
    Component   = "security-group"
    Environment = var.environment
  })
}

// === ARCHIVO: outputs.tf ===
# ==============================================================================
# Outputs de la Solución de Networking
# ==============================================================================
# Este archivo expone los valores generados por los módulos de networking
# para su consumo por otros módulos o proyectos Terraform.
# ==============================================================================

# ==============================================================================
# OUTPUTS DEL MÓDULO DE NETWORKING (VPC)
# ==============================================================================

output "vpc_id" {
  description = "ID de la VPC principal"
  value       = module.networking.vpc_id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = module.networking.vpc_cidr
}

output "vpc_name" {
  description = "Nombre de la VPC principal"
  value       = module.networking.vpc_name
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.networking.private_subnet_ids
}

output "public_subnet_azs" {
  description = "Zonas de disponibilidad de subredes públicas"
  value       = module.networking.public_subnet_azs
}

output "private_subnet_azs" {
  description = "Zonas de disponibilidad de subredes privadas"
  value       = module.networking.private_subnet_azs
}

output "nat_gateway_id" {
  description = "ID del NAT Gateway"
  value       = module.networking.nat_gateway_id
}

output "nat_gateway_ips" {
  description = "IPs elásticas asignadas al NAT Gateway"
  value       = module.networking.nat_gateway_ips
}

output "private_route_table_id" {
  description = "ID de la tabla de rutas privada"
  value       = module.networking.private_route_table_id
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = module.networking.public_route_table_id
}

output "igw_id" {
  description = "ID del Internet Gateway"
  value       = module.networking.igw_id
}

# ==============================================================================
# OUTPUTS DEL MÓDULO DE TRANSIT GATEWAY
# ==============================================================================

output "transit_gateway_id" {
  description = "ID del Transit Gateway"
  value       = module.transit_gateway.transit_gateway_id
}

output "transit_gateway_arn" {
  description = "ARN del Transit Gateway"
  value       = module.transit_gateway.transit_gateway_arn
}

output "transit_gateway_default_route_table_id" {
  description = "ID de la tabla de rutas por defecto del Transit Gateway"
  value       = module.transit_gateway.default_route_table_id
}

output "transit_gateway_default_route_table_arn" {
  description = "ARN de la tabla de rutas por defecto del Transit Gateway"
  value       = module.transit_gateway.default_route_table_arn
}

output "transit_gateway_association_default_route_table_id" {
  description = "ID de la tabla de rutas de asociación por defecto"
  value       = module.transit_gateway.association_default_route_table_id
}

output "transit_gateway_propagation_default_route_table_ids" {
  description = "IDs de las tablas de rutas con propagación habilitada"
  value       = module.transit_gateway.propagation_default_route_table_ids
}

# ==============================================================================
# OUTPUTS DEL MÓDULO DE VPN
# ==============================================================================

output "vpn_connection_id" {
  description = "ID de la conexión VPN principal"
  value       = module.vpn.vpn_connection_id
}

output "vpn_connection_ids" {
  description = "IDs de todas las conexiones VPN (incluyendo redundantes)"
  value       = module.vpn.vpn_connection_ids
}

output "vpn_attachment_id" {
  description = "ID del attachment de VPN al Transit Gateway"
  value       = module.vpn.vpn_attachment_id
}

output "customer_gateway_ip" {
  description = "IP pública del Customer Gateway"
  value       = module.vpn.customer_gateway_ip
}

output "vpn_tunnel_external_ip" {
  description = "IPs externas de los túneles VPN"
  value       = module.vpn.tunnel_external_ips
}

# ==============================================================================
# OUTPUTS DEL MÓDULO DE DIRECT CONNECT
# ==============================================================================

output "dx_connection_id" {
  description = "ID de la conexión Direct Connect"
  value       = module.direct_connect.dx_connection_id
}

output "dx_gateway_id" {
  description = "ID del Direct Connect Gateway"
  value       = module.direct_connect.dx_gateway_id
}

output "dx_gateway_attachment_id" {
  description = "ID del attachment de Direct Connect al Transit Gateway"
  value       = module.direct_connect.dx_gateway_attachment_id
}

output "dx_virtual_interface_id" {
  description = "ID de la interfaz virtual privada"
  value       = module.direct_connect.dx_virtual_interface_id
}

output "dx_connection_state" {
  description = "Estado de la conexión Direct Connect"
  value       = module.direct_connect.dx_connection_state
}

# ==============================================================================
# OUTPUTS DE SECURITY GROUPS
# ==============================================================================

output "network_management_security_group_id" {
  description = "ID del security group de gestión de red"
  value       = aws_security_group.network_management.id
}

output "inter_vpc_security_group_id" {
  description = "ID del security group de comunicación entre VPCs"
  value       = aws_security_group.inter_vpc.id
}

# ==============================================================================
# OUTPUTS DE RUTAS DEL TRANSIT GATEWAY
# ==============================================================================

output "transit_gateway_routes" {
  description = "Mapa de rutas configuradas en el Transit Gateway"
  value = {
    to_vpn             = var.on_premise_cidr
    to_direct_connect  = var.on_premise_networks
    to_additional_vpcs = { for k, v in var.additional_vpc_attachments : k => v.cidr }
  }
}

# ==============================================================================
# OUTPUTS DE CONECTIVIDAD RESUMEN
# ==============================================================================

output "connectivity_summary" {
  description = "Resumen de la configuración de conectividad"
  value = {
    vpc_count               = length(var.additional_vpc_attachments) + 1
    vpn_redundant           = var.enable_vpn_redundancy
    direct_connect_enabled  = var.enable_direct_connect
    nat_gateway_enabled     = var.enable_nat_gateway
    transit_gateway_enabled = true
    availability_zones      = var.availability_zones
  }
}

// === ARCHIVO: backend.tf ===
# ==============================================================================
# Configuración del Backend Remoto para Terraform
# ==============================================================================
# Este archivo configura el almacenamiento remoto del estado de Terraform
# utilizando S3 para persistencia y DynamoDB para bloqueo de estado.
# El estado remoto permite colaboración entre equipos y seguridad contra
# modificaciones concurrentes.
# ==============================================================================

terraform {
  backend "s3" {
    # ==============================================================================
    # CONFIGURACIÓN DEL BUCKET S3
    # ==============================================================================
    # Bucket donde se almacena el archivo de estado de Terraform.
    # El nombre del bucket debe ser único globalmente en AWS.
    # ==============================================================================
    bucket = "${var.project_name}-${var.environment}-terraform-state"

    # ==============================================================================
    # CLAVE DEL ESTADO DENTRO DEL BUCKET
    # ==============================================================================
    # Define la ruta dentro del bucket donde se almacena el estado.
    # Permite separar estados por ambiente y componente.
    # ==============================================================================
    key = "networking/terraform.tfstate"

    # ==============================================================================
    # REGIÓN DE AWS
    # ==============================================================================
    # Región donde reside el bucket S3 y la tabla DynamoDB.
    # ==============================================================================
    region = var.aws_region

    # ==============================================================================
    # HABILITAR CIFRADO DEL ESTADO
    # ==============================================================================
    # El estado se cifra automáticamente con SSE-S3 (AES-256).
    # ==============================================================================
    encrypt = true

    # ==============================================================================
    # TABLA DYNAMODB PARA BLOQUEO DE ESTADO
    # ==============================================================================
    # Utiliza DynamoDB para implementar bloqueo preventivo.
    # Evita que múltiples usuarios ejecuten Terraform simultáneamente.
    # ==============================================================================
    dynamodb_table = "${var.project_name}-${var.environment}-terraform-locks"

    # ==============================================================================
    # MODO DE REPLICACIÓN (opcional para producción)
    # ==============================================================================
    # Habilitar replicación entre regiones para recuperación ante desastres.
    # Descomentar si se requiere DR en otra región.
    # ==============================================================================
    # replication_configuration {
    #   replicate = {
    #     region     = "us-east-2"
    #   }
    # }

    # ==============================================================================
    # VERSIÓN DEL ESTADO
    # ==============================================================================
    # Habilita versioning del estado en S3 para auditoría y rollback.
    # ==============================================================================
    # versioned = true
  }
}

# ==============================================================================
# VARIABLES REFERENCIADAS POR EL BACKEND
# ==============================================================================
# Estas variables deben estar disponibles en el archivo terraform.tfvars
# del ambiente correspondiente para que el backend se inicialice correctamente.
# ==============================================================================

variable "project_name" {
  description = "Nombre del proyecto para naming de recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "aws_region" {
  description = "Región primaria de AWS"
  type        = string
}

# ==============================================================================
# NOTA SOBRE INICIALIZACIÓN DEL BACKEND
# ==============================================================================
# Para inicializar este backend, execute:
#   terraform init -backend-config="profile=default"
#
# Si el bucket o la tabla DynamoDB no existen, primero ejecute:
#   terraform init -backend=false
# para obtener el plan inicial, y luego cree los recursos de backend manualmente
# o mediante un módulo de bootstrap.
#
# El estado remoto es CRÍTICO para entornos de producción porque:
# 1. Permite colaboración entre múltiples miembros del equipo
# 2. Proporciona persistencia del estado entre ejecuciones
# 3. Evita conflictos mediante bloqueo con DynamoDB
# 4. Protege contra pérdida de estado local
# 5. Permite auditoría de cambios mediante versioning de S3
# ==============================================================================


// === ARCHIVO: README.md ===
# Terraform AWS Networking Solution

## Descripcion General

Este proyecto implementa una solucion de networking escalable y resiliente en AWS utilizando Terraform. La arquitectura esta diseñada para soportar la estrategia de nube de cualquier tamano, con componentes de alta disponibilidad como Transit Gateway, VPN redundantes, Direct Connect y NAT Gateway.

La solucion permite conexiones entre la nube AWS, infraestructura on-premise y entre VPCs, siguiendo las mejores practicas de segmentacion de red, principio de menor privilegio y optimizacion de costos mediante etiquetado adecuado de recursos.

## Topologia de la Solucion

```
                                    Internet
                                        |
                    +-------------------+-------------------+
                    |                                       |
              [Internet Gateway]                    [NAT Gateway]
                    |                                       |
    +---------------+---------------+       +---------------+---------------+
    |                               |       |                               |
    |   VPC Principal (Hub)         |       |   VPCs Spoke (Dev/QA/Prod)   |
    |   10.0.0.0/16                 |       |   10.1.0.0/16 (Dev)          |
    |                               |       |   10.2.0.0/16 (QA)           |
    |   +-----------------------+   |       |   10.3.0.0/16 (Prod)         |
    |   | Transit Gateway      |---+-------+                               |
    |   | Attachments:        |   |       |   Subnets Privadas:           |
    |   | - VPN (2x)          |   |       |   - 10.X.10.0/24 (App)        |
    |   | - Direct Connect    |   |       |   - 10.X.20.0/24 (Data)       |
    |   | - VPC Spokes        |   |       |   - 10.X.30.0/24 (Web)        |
    |   +-----------------------+   |       |                               |
    |                               |       |   Subnets Publicas:          |
    |   Subnets:                    |       |   - 10.X.100.0/24 (Public)   |
    |   - 10.0.10.0/24 (Publica)    |       |                               |
    |   - 10.0.20.0/24 (Privada)    |       +-------------------------------+
    |   - 10.0.30.0/24 (DMZ)        |                   |
    +---------------+---------------+                   |
                    |                                   |
        +-----------+-----------+           [VPC Peering / TGW]
        |                       |
  [VPN Gateway 1]      [VPN Gateway 2]
  (冗余)                     (冗余)
        |                       |
        +-----------+-----------+
                    |
            [On-Premise Data Center]
            Red: 172.16.0.0/12

[Direct Connect]
    |
    |
[Direct Connect Gateway]
    |
    |
[On-Premise via DX]
```

## Componentes de la Arquitectura

### Transit Gateway

El Transit Gateway acts como el centro de comunicacion central que conecta todas las VPCs y redes on-premise. Proporciona una arquitectura de tipo hub-and-spoke que simplifica la gestione de rutas y reduce la complejidad operativa. El modulo esta configurado para soportar multiples attachments simultaneos, incluyendo conexiones VPN, Direct Connect y VPCs adicionales que se pueden agregar en el futuro.

La configuracion incluye soporte para route tables personalizadas que permiten un control granular del trafico entre diferentes segmentos de la red. Cada VPC spoke tiene su propia tabla de rutas asociada, asegurando que el trafico fluya unicamente segun las politicas definidas por el equipo de seguridad.

### VPN Redundantes

Se implementan dos conexiones VPN independientes para garantizar la alta disponibilidad hacia el data center on-premise. Cada VPN esta conectada a un Virtual Private Gateway distinto y ambas rutas se anuncian via BGP para proporcionar failover automatico en caso de fallo de una de las conexiones.

La configuracion BGP incluye timers adaptativos que optimizan el tiempo de convergencia ante cambios en la topologia de red. El esquema de redundancia asegura un RTO (Recovery Time Objective) cercano a cero para la conectividad critica entre AWS y on-premise.

### Direct Connect

El modulo de Direct Connect proporciona una conexion dedicada de baja latencia hacia el data center on-premise. Esta conexion es complementaria a las VPNs y se utiliza para workloads que requieren latencia consistente y alto ancho de banda.

La arquitectura soporta multiples VIFs (Virtual Interfaces) para diferentes propositos: una VIF privada para acceso a recursos en VPCs y una VIF publica para servicios AWS publicos. El Direct Connect Gateway permite la consolidacion de multiples cuentas AWS bajo una sola conexion fisica.

### NAT Gateway

Los NAT Gateways se despliegan en cada VPC para permitir la salida a internet desde subredes privadas sin exponer los recursos a conexiones entrantes no solicitadas. La arquitectura contempla al menos un NAT Gateway por AZ para garantizar la disponibilidad.

El dimensionamiento del NAT Gateway considera los patrones de trafico esperados y esta preparado para escalar automaticamente mediante la configuracion de múltiples NAT Gateways en subredes diferentes.

### Segmentacion de Red

Cada VPC sigue un esquema de subredes consistente con tres capas de seguridad:

- **Subredes Publicas**: Hospedan recursos que requieren acceso directo a internet, como balanceadores de carga y NAT Gateways. Utilizan CIDRs en el rango 10.X.100.0/24.

- **Subredes de Aplicacion**: Contienen los servidores de aplicacion y microservicios. Estas subredes no tienen acceso directo a internet y todo el trafico saliente atraviesa el NAT Gateway. Rango: 10.X.10.0/24.

- **Subredes de Datos**: Albergan bases de datos y sistemas de almacenamiento. Tienen las restricciones mas estrictas y solo aceptan conexiones desde las subredes de aplicacion. Rango: 10.X.20.0/24.

- **Subredes DMZ**: Proporcionan una capa adicional de seguridad para servicios que requieren aislamiento adicional. Rango: 10.X.30.0/24.

## Estructura del Proyecto

```
.
├── README.md
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── variables.tf
├── environments
│   ├── dev
│   │   └── terraform.tfvars
│   ├── qa
│   │   └── terraform.tfvars
│   └── prod
│       └── terraform.tfvars
└── modules
    ├── networking
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── transit_gateway
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── vpn
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── direct_connect
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── nat_gateway
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```

## Requisitos Previos

Para utilizar este codigo se requiere:

- Terraform version 1.5 o superior
- AWS CLI configurado con credenciales validas
- Permisos IAM suficientes para crear los recursos de networking
- Acceso a la cuenta de AWS donde se desplegara la infraestructura

## Configuracion Inicial

El proyecto utiliza un backend remoto para almacenar el estado de Terraform. La configuracion del backend se encuentra en el archivo backend.tf. Antes de ejecutar cualquier comando, asegurese de que las credenciales de AWS esten correctamente configuradas en el sistema.

Para validar que el proyecto esta correctamente configurado, ejecute los siguientes comandos en la raiz del proyecto:

```bash
terraform init -backend=false
terraform validate
terraform fmt -check
```

El comando `terraform init` descarga los providers necesarios y configura el backend. El flag `-backend=false` se utiliza para omitir la configuracion del backend durante la fase de validacion inicial.

El comando `terraform validate` verifica que la sintaxis de los archivos de configuracion sea correcta y que todas las referencias a variables y recursos sean validas.

El comando `terraform fmt -check` verifica que el formato del codigo cumpla con los estandares de Terraform. Si el formato no es el esperado, puede ejecutar `terraform fmt` para corregirlo automaticamente.

## Despliegue por Ambiente

El proyecto esta estructurado para soportar multiples ambientes (dev, qa, prod) con valores de configuracion especificos en cada uno. Cada ambiente tiene su propio archivo terraform.tfvars que define los valores de las variables.

### Desarrollo

Para desplegar en el ambiente de desarrollo:

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### QA

Para despleujar en el ambiente de QA:

```bash
cd environments/qa
terraform init
terraform plan
terraform apply
```

### Produccion

Para desplegar en el ambiente de produccion:

```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

## Consideraciones de Seguridad

### Principios Implementados

La arquitectura implementa el principio de menor privilegio en todos los niveles. Las politicas IAM asociadas a los roles de servicios utilizan permisos especificos para cada recurso en lugar de permisos wildcard. Las security groups están configurados para permitir unicamente el trafico necesario entre los diferentes componentes.

### Cifrado

Todo el trafico entre componentes de la red esta cifrado en tránsito. Las conexiones VPN utilizan AES-256 para el cifrado del tunel. Direct Connect soporta cifrado mediante MACsec en la capa de enlace y TLS en capas superiores.

### Logging y Monitoreo

Los flujos de trafico de VPC se encuentran habilitados en todas las VPCs para permitir el analisis de patrones de trafico y la deteccion de anomalias. CloudWatch Logs se configura para capturar los logs de los recursos de networking con retencion configurable por ambiente.

## Gobernanza Multi-Cuenta

La solucion esta diseñada para integrarse con una estrategia de landing zone que contempla multiples cuentas AWS. El Transit Gateway permite la conexion de VPCs en diferentes cuentas mediante el uso de AWS Resource Access Manager.

El esquema de etiquetado (tags) sigue las convenciones de la organizacion y permite:

- Identificacion de costos por ambiente y proyecto
- Clasificacion de recursos segun su nivel de criticidad
- Trazabilidad de recursos para auditorias de seguridad
- Automatizacion de politicas de governanza mediante AWS Config

## Variables de Configuracion

Las variables principales del proyecto incluyen los rangos CIDR de cada VPC, los identificadores de las conexiones VPN y Direct Connect, y los parametros de configuracion BGP. Cada variable esta documentada en el archivo variables.tf con su descripcion, tipo y valores validos.

Los valores especificos por ambiente se encuentran en los archivos terraform.tfvars de cada directorio de ambiente. Esta separacion permite mantener configuraciones distintas para cada entorno sin modificar el codigo base.

## Mantenimiento y Operacion

Para actualizar la infraestructura, modifique los archivos de configuracion segun sea necesario y ejecute `terraform plan` para revisar los cambios propuestos. Despues de validar los cambios, aplique las modificaciones con `terraform apply`.

Es importante revisar siempre el plan de Terraform antes de aplicar para evitar cambios no deseados en la infraestructura existente. El estado de Terraform se almacena en el backend remoto configurado, lo que permite el trabajo colaborativo y la trazabilidad de cambios.


// === ARCHIVO: environments/dev/terraform.tfvars ===
environment                = "dev"
aws_region                 = "us-east-1"

# Configuración de cuenta AWS
aws_account_id            = "123456789012"

# Redes VPC principales
vpc_cidr_block            = "10.0.0.0/16"
availability_zones        = ["us-east-1a", "us-east-1b"]

# Subnets - Desarrollo (menor redundancia, costos optimizados)
public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs      = ["10.0.10.0/24", "10.0.20.0/24"]
database_subnet_cidrs     = ["10.0.100.0/24", "10.0.200.0/24"]

# NAT Gateway - Desarrollo (una sola zona para costos)
nat_gateway_enabled       = true
nat_single_az            = true

# Transit Gateway - Desarrollo (conexión básica)
transit_gateway_enabled  = true
transit_gateway_asn      = 64512
enable_dhcp_options      = false

# VPN Connections - Desarrollo (una conexión redundante)
vpn_connection_enabled   = true
vpn_redundancy_required  = false
vpn_bgp_asn              = 65001
customer_gateway_ip_1    = "203.0.113.10"
customer_gateway_ip_2    = "203.0.113.20"

# Direct Connect - Desarrollo (sin DX en dev)
direct_connect_enabled   = false
dx_location              = ""
dx_virtual_interface_name = ""

# Etiquetado para costos y gestión
common_tags = {
  Environment     = "dev"
  Project         = "networking-solution"
  CostCenter      = "IT-Dev"
  ManagedBy       = "Terraform"
  Owner           = "cloudops-team"
}

# Configuración de alta disponibilidad
ha_enabled               = false
multi_az                 = false

# Configuración de DNS
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración de flow logs
flow_logs_enabled        = false
flow_logs_retention_days = 7

# Configuración de seguridad de red
enable_vpc_flow_logs     = false
enable_security_groups   = true
allow_internal_traffic  = true

// === ARCHIVO: environments/qa/terraform.tfvars ===
environment                = "qa"
aws_region                 = "us-east-1"

# Configuración de cuenta AWS
aws_account_id            = "123456789012"

# Redes VPC principales
vpc_cidr_block            = "10.1.0.0/16"
availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Subnets - QA (redundancia parcial, 2 AZs)
public_subnet_cidrs       = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnet_cidrs      = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
database_subnet_cidrs     = ["10.1.100.0/24", "10.1.200.0/24", "10.1.300.0/24"]

# NAT Gateway - QA (redundancia en 2 AZs)
nat_gateway_enabled       = true
nat_single_az            = false

# Transit Gateway - QA (conexión completa)
transit_gateway_enabled  = true
transit_gateway_asn      = 64513
enable_dhcp_options      = true

# VPN Connections - QA (conexión redundante)
vpn_connection_enabled   = true
vpn_redundancy_required  = true
vpn_bgp_asn              = 65002
customer_gateway_ip_1    = "203.0.113.30"
customer_gateway_ip_2    = "203.0.113.40"

# Direct Connect - QA (DX básico sin redundancia)
direct_connect_enabled   = true
dx_location              = "EqDC2"
dx_virtual_interface_name = "qa-dx-vif-01"
dx_connection_id         = "dxcon-fghi5678"
dx_vlan                  = 101
dx_bgp_asn               = 65010
dx_auth_key              = ""

# Etiquetado para costos y gestión
common_tags = {
  Environment     = "qa"
  Project         = "networking-solution"
  CostCenter      = "IT-QA"
  ManagedBy       = "Terraform"
  Owner           = "cloudops-team"
  Compliance      = "SOC2"
}

# Configuración de alta disponibilidad
ha_enabled               = true
multi_az                 = true

# Configuración de DNS
enable_dns_hostnames     = true
enable_dns_support       = true

# Configuración de flow logs
flow_logs_enabled        = true
flow_logs_retention_days = 30

# Configuración de seguridad de red
enable_vpc_flow_logs     = true
enable_security_groups   = true
allow_internal_traffic  = true

// === ARCHIVO: environments/prod/terraform.tfvars ===
environment                = "prod"
aws_region                 = "us-east-1"

# Configuración de cuenta AWS
aws_account_id            = "987654321098"

# Redes VPC principales - Producción con espacio para crecimiento
vpc_cidr_block            = "10.2.0.0/15"
availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]

# Subnets - Producción (máxima redundancia, 6 AZs)
public_subnet_cidrs       = [
  "10.2.1.0/24",
  "10.2.2.0/24",
  "10.2.3.0/24",
  "10.2.4.0/24",
  "10.2.5.0/24",
  "10.2.6.0/24"
]
private_subnet_cidrs      = [
  "10.2.10.0/24",
  "10.2.20.0/24",
  "10.2.30.0/24",
  "10.2.40.0/24",
  "10.2.50.0/24",
  "10.2.60.0/24"
]
 database_subnet_cidrs    = [
  "10.2.100.0/24",
  "10.2.200.0/24",
  "10.2.300.0/24",
  "10.2.400.0/24",
  "10.2.500.0/24",
  "10.2.600.0/24"
]

# NAT Gateway - Producción (máxima redundancia, cada AZ)
nat_gateway_enabled       = true
nat_single_az            = false
nat_per_az               = true

# Transit Gateway - Producción (alta capacidad)
transit_gateway_enabled  = true
transit_gateway_asn      = 64514
transit_gateway_ecmp     = true
enable_dhcp_options      = true

# VPN Connections - Producción (redundancia completa con ECMP)
vpn_connection_enabled   = true
vpn_redundancy_required  = true
vpn_bgp_asn              = 65003
vpn_ecmp_enabled         = true
customer_gateway_ip_1    = "203.0.113.50"
customer_gateway_ip_2    = "203.0.113.60"
customer_gateway_ip_3    = "203.0.113.70"
customer_gateway_ip_4    = "203.0.113.80"

# Direct Connect - Producción (redundante con failover)
direct_connect_enabled   = true
dx_location              = "EqDC2"
dx_virtual_interface_name = "prod-dx-vif-primary"
dx_connection_id         = "dxcon-abcd1234"
dx_connection_id_secondary = "dxcon-wxyz5678"
dx_vlan                  = 201
dx_vlan_secondary        = 202
dx_bgp_asn               = 65020
dx_bgp_asn_secondary     = 65021
dx_auth_key              = ""
dx_hosted_connections    = []

# Etiquetado para costos y gestión - Producción
common_tags = {
  Environment     = "prod"
  Project         = "networking-solution"
  CostCenter      = "IT-Production"
  ManagedBy       = "Terraform"
  Owner           = "cloudops-team"
  Compliance      = "SOC2-PCI"
  MissionCritical = "true"
  RPO             = "1H"
  RTO             = "4H"
}

# Configuración de alta disponibilidad - Producción	ha_enabled               = true
multi_az                 = true
enable_cross_zone_lb     = true

# Configuración de DNS
enable_dns_hostnames     = true
enable_dns_support       = true
private_hosted_zone      = true

# Configuración de flow logs - Producción
flow_logs_enabled        = true
flow_logs_retention_days = 90
flow_logs_cloudwatch     = true
flow_logs_s3             = true
flow_logs_s3_bucket      = "prod-vpc-flow-logs-archive"

# Configuración de seguridad de red - Producción
enable_vpc_flow_logs     = true
enable_security_groups   = true
allow_internal_traffic  = true
enable_deletion_protection = true
enable_network_firewall  = false

# Configuración de monitoreo
enable_vpn_metrics       = true
enable_tgw_attachments   = true
enable_transit_gateway_route_monitoring = true

```

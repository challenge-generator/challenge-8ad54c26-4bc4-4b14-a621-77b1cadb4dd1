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
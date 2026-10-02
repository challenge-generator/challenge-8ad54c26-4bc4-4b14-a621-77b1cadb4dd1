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
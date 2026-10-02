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
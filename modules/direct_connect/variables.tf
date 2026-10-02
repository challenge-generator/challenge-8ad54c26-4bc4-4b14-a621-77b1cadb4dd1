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
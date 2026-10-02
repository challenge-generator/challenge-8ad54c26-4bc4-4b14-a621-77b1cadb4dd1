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
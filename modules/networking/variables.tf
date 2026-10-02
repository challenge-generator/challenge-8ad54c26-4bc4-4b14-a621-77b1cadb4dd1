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
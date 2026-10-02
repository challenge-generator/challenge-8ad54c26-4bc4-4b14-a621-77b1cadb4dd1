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
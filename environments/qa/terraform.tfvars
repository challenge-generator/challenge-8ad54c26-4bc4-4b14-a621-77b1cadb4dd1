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
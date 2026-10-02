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
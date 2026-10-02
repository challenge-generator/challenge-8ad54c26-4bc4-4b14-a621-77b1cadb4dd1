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
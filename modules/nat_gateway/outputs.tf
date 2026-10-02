# --------------------------------------------------------------
# Outputs del módulo de NAT Gateway
# Expone información necesaria para otros módulos y recursos
# --------------------------------------------------------------

# ID del NAT Gateway para referencia en otras partes del código
output "nat_gateway_ids" {
  description = "Map de IDs de NAT Gateway por zona de disponibilidad"
  value       = { for az, nat in aws_nat_gateway.main : az => nat.id }
}

# IDs de las IPs elásticas asociadas a los NAT Gateways
output "eip_allocation_ids" {
  description = "Map de IDs de asignación de EIP por zona de disponibilidad"
  value       = { for az, eip in aws_eip.nat : az => eip.id }
}

# IDs de las tablas de rutas privadas
output "private_route_table_ids" {
  description = "Map de IDs de tablas de rutas privadas por zona de disponibilidad"
  value       = { for az, rt in aws_route_table.private : az => rt.id }
}

# ID de la tabla de rutas pública
output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

# ID del Internet Gateway
output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# ARNs de los NAT Gateways para políticas IAM y monitoreo
output "nat_gateway_arns" {
  description = "Map de ARNs de NAT Gateway por zona de disponibilidad"
  value       = { for az, nat in aws_nat_gateway.main : az => nat.arn }
}

# IPs públicas asignadas a los NAT Gateways
output "nat_gateway_public_ips" {
  description = "Map de IPs públicas de NAT Gateway por zona de disponibilidad"
  value       = { for az, eip in aws_eip.nat : az => eip.public_ip }
}

# Subredes públicas donde están desplegados los NAT Gateways
output "nat_gateway_subnet_ids" {
  description = "Map de IDs de subredes públicas usadas por NAT Gateway"
  value       = var.public_subnet_ids
}

# IDs de las tablas de enrutamiento privadas para asociación con subredes
output "all_private_route_tables" {
  description = "Lista completa de IDs de tablas de rutas privadas"
  value       = values(aws_route_table.private)[*].id
}
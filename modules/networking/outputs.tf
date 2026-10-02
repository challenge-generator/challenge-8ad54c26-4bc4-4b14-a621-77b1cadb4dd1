output "vpc_id" {
  description = "ID de la VPC principal"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "Bloque CIDR de la VPC principal"
  value       = aws_vpc.main.cidr_block
}

output "vpc_name" {
  description = "Nombre de la VPC"
  value       = aws_vpc.main.tags["Name"]
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "Bloques CIDR de las subredes públicas"
  value       = aws_subnet.public[*].cidr_block
}

output "public_subnet_azs" {
  description = "Zonas de disponibilidad de las subredes públicas"
  value       = aws_subnet.public[*].availability_zone
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = { for k, v in aws_subnet.private : k => v.id }
}

output "private_subnet_cidrs" {
  description = "Bloques CIDR de las subredes privadas"
  value       = { for k, v in aws_subnet.private : k => v.cidr_block }
}

output "private_subnet_azs" {
  description = "Zonas de disponibilidad de las subredes privadas"
  value       = { for k, v in aws_subnet.private : k => v.availability_zone }
}

output "private_subnet_ids_by_tier" {
  description = "IDs de subredes privadas agrupadas por tier"
  value = {
    for k, v in aws_subnet.private :
    v.tags["Tier"] => concat(
      [for subnet in aws_subnet.private : subnet.id if subnet.tags["Tier"] == v.tags["Tier"]],
    )
  }
}

output "public_route_table_id" {
  description = "ID de la tabla de rutas pública"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas por tier"
  value       = aws_route_table.private[*].id
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}

output "nat_gateway_ips" {
  description = "IPs elásticas asignadas a los NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "default_security_group_id" {
  description = "ID del security group por defecto"
  value       = aws_security_group.default.id
}

output "vpc_attributes" {
  description = "Atributos completos de la VPC"
  value = {
    id                    = aws_vpc.main.id
    cidr_block            = aws_vpc.main.cidr_block
    enable_dns_hostnames = aws_vpc.main.enable_dns_hostnames
    enable_dns_support   = aws_vpc.main.enable_dns_support
    instance_tenancy      = aws_vpc.main.instance_tenancy
    default_security_group = aws_security_group.default.id
    igw_id                = aws_internet_gateway.main.id
  }
}
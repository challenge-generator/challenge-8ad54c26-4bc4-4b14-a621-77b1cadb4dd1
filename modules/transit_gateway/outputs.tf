output "transit_gateway_id" {
  description = "ID del Transit Gateway"
  value       = aws_ec2_transit_gateway.main.id
}

output "transit_gateway_arn" {
  description = "ARN del Transit Gateway"
  value       = aws_ec2_transit_gateway.main.arn
}

output "transit_gateway_owner_account_id" {
  description = "ID de la cuenta dueña del Transit Gateway"
  value       = aws_ec2_transit_gateway.main.owner_id
}

output "association_default_route_table_id" {
  description = "ID de la tabla de rutas de asociación por defecto"
  value       = aws_ec2_transit_gateway.main.association_default_route_table_id
}

output "propagation_default_route_table_id" {
  description = "ID de la tabla de rutas de propagación por defecto"
  value       = aws_ec2_transit_gateway.main.propagation_default_route_table_id
}

output "vpc_attachment_ids" {
  description = "Lista de IDs de los attachments de VPC"
  value       = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[*].id
}

output "vpc_attachment_vpc_ids" {
  description = "Lista de IDs de las VPCs conectadas al Transit Gateway"
  value       = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[*].vpc_id
}

output "custom_route_table_ids" {
  description = "Lista de IDs de las tablas de rutas personalizadas"
  value       = aws_ec2_transit_gateway_route_table.route_tables[*].id
}

output "peering_attachment_id" {
  description = "ID del attachment de peering (si existe)"
  value       = length(aws_ec2_transit_gateway_peering_attachment.peering) > 0 ? aws_ec2_transit_gateway_peering_attachment.peering[0].id : null
}

output "connect_attachment_ids" {
  description = "Lista de IDs de los attachments de Connect"
  value       = aws_ec2_transit_gateway_connect.connect[*].id
}
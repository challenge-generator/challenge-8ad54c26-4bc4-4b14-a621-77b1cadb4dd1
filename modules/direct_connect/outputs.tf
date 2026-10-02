output "connection_ids" {
  description = "Lista de IDs de las conexiones Direct Connect creadas"
  value       = aws_dx_connection.main[*].id
}

output "connection_id_primary" {
  description = "ID de la conexión Direct Connect primaria"
  value       = aws_dx_connection.main[0].id
}

output "connection_arns" {
  description = "ARNs de las conexiones Direct Connect"
  value       = aws_dx_connection.main[*].arn
}

output "connection_state" {
  description = "Estado de las conexiones Direct Connect"
  value       = { for conn in aws_dx_connection.main : conn.id => conn.state }
}

output "private_virtual_interface_ids" {
  description = "IDs de los Virtual Interfaces privados"
  value       = aws_dx_private_virtual_interface.private_vif[*].id
}

output "private_virtual_interface_id_primary" {
  description = "ID del Virtual Interface privado primario"
  value       = length(aws_dx_private_virtual_interface.private_vif) > 0 ? aws_dx_private_virtual_interface.private_vif[0].id : ""
}

output "private_virtual_interface_arns" {
  description = "ARNs de los Virtual Interfaces privados"
  value       = aws_dx_private_virtual_interface.private_vif[*].arn
}

output "private_virtual_interface_state" {
  description = "Estado de los Virtual Interfaces privados"
  value       = { for vif in aws_dx_private_virtual_interface.private_vif : vif.id => vif.state }
}

output "public_virtual_interface_ids" {
  description = "IDs de los Virtual Interfaces públicos"
  value       = aws_dx_public_virtual_interface.public_vif[*].id
}

output "public_virtual_interface_id_primary" {
  description = "ID del Virtual Interface público primario"
  value       = length(aws_dx_public_virtual_interface.public_vif) > 0 ? aws_dx_public_virtual_interface.public_vif[0].id : ""
}

output "public_virtual_interface_arns" {
  description = "ARNs de los Virtual Interfaces públicos"
  value       = aws_dx_public_virtual_interface.public_vif[*].arn
}

output "public_virtual_interface_state" {
  description = "Estado de los Virtual Interfaces públicos"
  value       = { for vif in aws_dx_public_virtual_interface.public_vif : vif.id => vif.state }
}

output "hosted_transit_virtual_interface_id" {
  description = "ID del Virtual Interface de tránsito hospedado"
  value       = length(aws_dx_hosted_transit_virtual_interface.hosted_transit_vif) > 0 ? aws_dx_hosted_transit_virtual_interface.hosted_transit_vif[0].id : ""
}

output "hosted_private_virtual_interface_id" {
  description = "ID del Virtual Interface privado hospedado"
  value       = length(aws_dx_hosted_private_virtual_interface.hosted_private_vif) > 0 ? aws_dx_hosted_private_virtual_interface.hosted_private_vif[0].id : ""
}

output "hosted_public_virtual_interface_id" {
  description = "ID del Virtual Interface público hospedado"
  value       = length(aws_dx_hosted_public_virtual_interface.hosted_public_vif) > 0 ? aws_dx_hosted_public_virtual_interface.hosted_public_vif[0].id : ""
}

output "lag_id" {
  description = "ID del LAG (Link Aggregation Group) de Direct Connect"
  value       = length(aws_dx_lag.dx_lag) > 0 ? aws_dx_lag.dx_lag[0].id : ""
}

output "lag_arn" {
  description = "ARN del LAG de Direct Connect"
  value       = length(aws_dx_lag.dx_lag) > 0 ? aws_dx_lag.dx_lag[0].arn : ""
}

output "lag_state" {
  description = "Estado del LAG de Direct Connect"
  value       = length(aws_dx_lag.dx_lag) > 0 ? aws_dx_lag.dx_lag[0].state : ""
}

output "all_virtual_interface_ids" {
  description = "Todos los IDs de Virtual Interfaces (privados, públicos y hospedados)"
  value       = concat(
    aws_dx_private_virtual_interface.private_vif[*].id,
    aws_dx_public_virtual_interface.public_vif[*].id,
    aws_dx_hosted_transit_virtual_interface.hosted_transit_vif[*].id,
    aws_dx_hosted_private_virtual_interface.hosted_private_vif[*].id,
    aws_dx_hosted_public_virtual_interface.hosted_public_vif[*].id
  )
}

output "connection_details" {
  description = "Detalles completos de las conexiones Direct Connect"
  value = [for conn in aws_dx_connection.main : {
    id         = conn.id
    name       = conn.name
    location   = conn.location
    bandwidth  = conn.bandwidth
    state      = conn.state
    arn        = conn.arn
    tags       = conn.tags
  }]
}
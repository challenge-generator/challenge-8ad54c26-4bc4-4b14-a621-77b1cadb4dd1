output "vpn_connection_ids" {
  description = "Lista de IDs de las conexiones VPN creadas"
  value       = aws_vpn_connection.main[*].id
}

output "vpn_connection_id_primary" {
  description = "ID de la conexión VPN primaria"
  value       = aws_vpn_connection.main[0].id
}

output "vpn_connection_id_secondary" {
  description = "ID de la conexión VPN secundaria para alta disponibilidad"
  value       = length(aws_vpn_connection.main) > 1 ? aws_vpn_connection.main[1].id : ""
}

output "vpn_tunnel_external_ip_primary" {
  description = "IP externa del túnel primario de la primera conexión VPN"
  value       = aws_vpn_connection.main[0].tunnel1_inside_ip_address
}

output "vpn_tunnel_external_ip_secondary" {
  description = "IP externa del túnel secundario de la primera conexión VPN"
  value       = aws_vpn_connection.main[0].tunnel2_inside_ip_address
}

output "vpn_customer_gateway_ip_primary" {
  description = "IP del Customer Gateway para la conexión primaria"
  value       = aws_customer_gateway.main[0].ip_address
}

output "vpn_customer_gateway_ip_secondary" {
  description = "IP del Customer Gateway para la conexión secundaria"
  value       = length(aws_customer_gateway.main) > 1 ? aws_customer_gateway.main[1].ip_address : ""
}

output "vpn_customer_gateway_arns" {
  description = "ARNs de los Customer Gateways creados"
  value       = aws_customer_gateway.main[*].arn
}

output "vpn_transit_gateway_attachment_ids" {
  description = "IDs de los attachments al Transit Gateway"
  value       = aws_vpn_connection.main[*].transit_gateway_attachment_id
}

output "vpn_routing_table_id" {
  description = "ID de la tabla de rutas asociada a las conexiones VPN"
  value       = length(aws_vpn_connection.main) > 0 ? aws_vpn_connection.main[0].routes[0].destination_cidr_block_configured : ""
}

output "vpn_status" {
  description = "Estado de las conexiones VPN"
  value       = { for conn in aws_vpn_connection.main : conn.id => conn.state }
}

output "vpn_tags" {
  description = "Tags aplicados a las conexiones VPN"
  value       = { for conn in aws_vpn_connection.main : conn.id => conn.tags }
}
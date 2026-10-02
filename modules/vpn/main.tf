resource "aws_customer_gateway" "customer_gateways" {
  count = length(var.customer_gateways)

  bgp_asn    = var.customer_gateways[count.index].bgp_asn
  ip_address = var.customer_gateways[count.index].ip_address
  type       = var.customer_gateways[count.index].type

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-cgw-${var.customer_gateways[count.index].name}"
    }
  )
}

resource "aws_vpn_connection" "vpn_connections" {
  count = length(var.vpn_connections)

  customer_gateway_id = var.vpn_connections[count.index].customer_gateway_id
  type                = var.vpn_connections[count.index].type
  static_routes_only  = var.vpn_connections[count.index].static_routes_only

  tunnel_inside_ip_version = var.vpn_connections[count.index].tunnel_inside_ip_version
  tunnel1_preshared_key    = var.vpn_connections[count.index].tunnel1_preshared_key
  tunnel1_inside_cidr      = var.vpn_connections[count.index].tunnel1_inside_cidr
  tunnel2_preshared_key    = var.vpn_connections[count.index].tunnel2_preshared_key
  tunnel2_inside_cidr      = var.vpn_connections[count.index].tunnel2_inside_cidr

  enable_acceleration         = var.vpn_connections[count.index].enable_acceleration
  local_ipv4_network_cidr     = var.vpn_connections[count.index].local_ipv4_network_cidr
  remote_ipv4_network_cidr    = var.vpn_connections[count.index].remote_ipv4_network_cidr

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpn-${var.vpn_connections[count.index].name}"
    }
  )
}

resource "aws_vpn_connection_route" "static_routes" {
  count = length(var.vpn_static_routes)

  destination_cidr_block = var.vpn_static_routes[count.index].destination_cidr_block
  vpn_connection_id      = var.vpn_static_routes[count.index].vpn_connection_id
}

resource "aws_customer_gateway" "dynamic_customer_gateway" {
  count = var.dynamic_routing_customer_gateway != null ? 1 : 0

  bgp_asn    = var.dynamic_routing_customer_gateway.bgp_asn
  ip_address = var.dynamic_routing_customer_gateway.ip_address
  type       = "ipsec.1"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-cgw-dynamic"
    }
  )
}

resource "aws_vpn_connection" "dynamic_vpn_connection" {
  count = var.dynamic_routing_config != null ? 1 : 0

  customer_gateway_id = aws_customer_gateway.dynamic_customer_gateway[0].id
  type                = "ipsec.1"
  static_routes_only  = false

  dynamic_routing_config {
    routing_type = var.dynamic_routing_config.routing_type
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpn-dynamic"
    }
  )
}

resource "aws_ec2_transit_gateway_vpn_attachment" "tgw_vpn_attachment" {
  count = var.attach_to_transit_gateway ? length(var.vpn_connections) : 0

  transit_gateway_id = var.transit_gateway_id
  vpn_connection_id  = aws_vpn_connection.vpn_connections[count.index].id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-tgw-vpn-${count.index}"
    }
  )
}

resource "aws_vpn_connection" "redundant_vpn" {
  count = var.redundant_vpn_config != null ? 1 : 0

  customer_gateway_id = var.redundant_vpn_config.customer_gateway_id
  type                = "ipsec.1"
  static_routes_only  = var.redundant_vpn_config.static_routes_only

  tunnel_inside_ip_version = "ipv4"
  tunnel1_preshared_key    = var.redundant_vpn_config.tunnel1_preshared_key
  tunnel1_inside_cidr      = var.redundant_vpn_config.tunnel1_inside_cidr
  tunnel2_preshared_key    = var.redundant_vpn_config.tunnel2_preshared_key
  tunnel2_inside_cidr      = var.redundant_vpn_config.tunnel2_inside_cidr

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-vpn-redundant"
    }
  )
}

resource "aws_vpn_connection_metric" "vpn_metrics" {
  count = length(aws_vpn_connection.vpn_connections)

  vpn_connection_id = aws_vpn_connection.vpn_connections[count.index].id
}
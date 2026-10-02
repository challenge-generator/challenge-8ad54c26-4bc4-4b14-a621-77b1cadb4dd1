resource "aws_ec2_transit_gateway" "main" {
  amazon_asn               = var.amazon_asn
  auto_accept_shared_attachments = var.auto_accept_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  description               = var.description
  dns_support              = var.dns_support
  multicast_support        = var.multicast_support
  vpn_ecmp_support         = var.vpn_ecmp_support

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-tgw"
    }
  )
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachments" {
  count = length(var.vpc_attachments)

  subnet_ids         = var.vpc_attachments[count.index].subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = var.vpc_attachments[count.index].vpc_id

  dns_support        = var.vpc_attachments[count.index].enable_dns_support != null ? var.vpc_attachments[count.index].enable_dns_support : "enable"
  ipv6_support       = var.vpc_attachments[count.index].enable_ipv6_support != null ? var.vpc_attachments[count.index].enable_ipv6_support : "disable"

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-attachment-${var.vpc_attachments[count.index].vpc_name}"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table" "route_tables" {
  count = length(var.custom_route_tables) > 0 ? length(var.custom_route_tables) : 0

  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-rt-${var.custom_route_tables[count.index].name}"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "associations" {
  count = length(var.vpc_attachments)

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[count.index].id
  transit_gateway_route_table_id = length(var.custom_route_tables) > 0 ? aws_ec2_transit_gateway_route_table.route_tables[0].id : aws_ec2_transit_gateway.main.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "propagations" {
  count = length(var.vpc_attachments)

  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[count.index].id
  transit_gateway_route_table_id = length(var.custom_route_tables) > 0 ? aws_ec2_transit_gateway_route_table.route_tables[0].id : aws_ec2_transit_gateway.main.propagation_default_route_table_id
}

resource "aws_ec2_transit_gateway_route" "static_routes" {
  count = length(var.static_routes)

  destination_cidr_block         = var.static_routes[count.index].destination_cidr_block
  transit_gateway_attachment_id  = var.static_routes[count.index].attachment_id != null ? var.static_routes[count.index].attachment_id : aws_ec2_transit_gateway_vpc_attachment.vpc_attachments[0].id
  transit_gateway_route_table_id = length(var.custom_route_tables) > 0 ? aws_ec2_transit_gateway_route_table.route_tables[0].id : aws_ec2_transit_gateway.main.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_peering_attachment" "peering" {
  count = var.peering_config != null ? 1 : 0

  acceptor_account_id         = var.peering_config.acceptor_account_id
  acceptor_transit_gateway_id = var.peering_config.acceptor_tgw_id
  provider_account_id         = var.peering_config.provider_account_id
  requester_transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-peering"
    }
  )
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "peering_accepter" {
  count = var.peering_accepter_config != null ? 1 : 0

  transit_gateway_attachment_id = var.peering_accepter_config.attachment_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-peering-accepter"
    }
  )
}

resource "aws_ec2_transit_gateway_connect" "connect" {
  count = length(var.connect_attachments)

  transport_attachment_id = var.connect_attachments[count.index].transport_attachment_id
  transit_gateway_id     = aws_ec2_transit_gateway.main.id
  protocol               = var.connect_attachments[count.index].protocol

  tags = merge(
    var.common_tags,
    {
      Name = "${var.name_prefix}-connect-${count.index}"
    }
  )
}
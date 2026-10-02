locals {
  dx_tags = merge(
    var.common_tags,
    var.dx_tags,
    {
      "Environment" = var.environment
      "ManagedBy"   = "Terraform"
    }
  )

  vlan_range = range(var.first_vlan, var.first_vlan + var.connection_count * 1000)

  virtual_interface_names = var.virtual_interface_names != null ? var.virtual_interface_names : [for i in range(var.connection_count) : "${var.environment}-vif-${i}"]
}

resource "aws_dx_connection" "main" {
  count = var.connection_count

  name      = "${var.environment}-dx-connection-${count.index}"
  location  = var.dx_location
  bandwidth = var.bandwidth
  provider  = var.aws_provider

  encryption_mode = var.encryption_mode

  tags = merge(local.dx_tags, {
    "Name" = "${var.environment}-dx-${count.index}"
  })

  timeouts {
    create = var.connection_timeout
    delete = var.connection_timeout
    update = var.connection_timeout
  }
}

resource "aws_dx_private_virtual_interface" "private_vif" {
  count = var.create_private_vif ? var.connection_count : 0

  name                  = "${local.virtual_interface_names[count.index]}-private"
  connection_id         = aws_dx_connection.main[count.index].id
  vlan                  = local.vlan_range[count.index]
  address_family        = "ipv4"
  bgp_asn               = var.bgp_asn
  customer_address      = var.customer_address
  mtu                   = var.private_vif_mtu
  virtual_interface_id  = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-private-vif-${count.index}"
    "Type"        = "Private"
    "Environment" = var.environment
  })

  depends_on = [aws_dx_connection.main]
}

resource "aws_dx_public_virtual_interface" "public_vif" {
  count = var.create_public_vif ? var.connection_count : 0

  name                  = "${local.virtual_interface_names[count.index]}-public"
  connection_id         = aws_dx_connection.main[count.index].id
  vlan                  = local.vlan_range[count.index + 500]
  address_family        = "ipv4"
  bgp_asn               = var.bgp_asn
  customer_address      = var.customer_address
  mtu                   = var.public_vif_mtu
  virtual_interface_id  = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-public-vif-${count.index}"
    "Type"        = "Public"
    "Environment" = var.environment
  })

  depends_on = [aws_dx_connection.main]
}

resource "aws_dx_hosted_transit_virtual_interface" "hosted_transit_vif" {
  count = var.create_hosted_transit_vif ? 1 : 0

  name                 = "${var.environment}-hosted-transit-vif"
  connection_id        = var.hosted_connection_id
  vlan                 = var.hosted_vlan
  address_family       = "ipv4"
  bgp_asn              = var.bgp_asn
  customer_address     = var.customer_address
  mtu                  = var.hosted_vif_mtu
  owner_account_id     = var.hosted_owner_account_id
  amazon_address       = var.amazon_address
  virtual_interface_id = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-hosted-transit-vif"
    "Type"        = "HostedTransit"
    "Environment" = var.environment
  })
}

resource "aws_dx_hosted_private_virtual_interface" "hosted_private_vif" {
  count = var.create_hosted_private_vif ? 1 : 0

  name                 = "${var.environment}-hosted-private-vif"
  connection_id        = var.hosted_connection_id
  vlan                 = var.hosted_vlan
  address_family       = "ipv4"
  bgp_asn              = var.bgp_asn
  customer_address     = var.customer_address
  mtu                  = var.hosted_vif_mtu
  owner_account_id     = var.hosted_owner_account_id
  amazon_address       = var.amazon_address
  virtual_interface_id = var.existing_virtual_interface_id

  bgp_peer_config {
    peer_asn    = var.peer_bgp_asn
    peer_ip    = var.peer_ip
    bgp_status = "Available"
  }

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-hosted-private-vif"
    "Type"        = "HostedPrivate"
    "Environment" = var.environment
  })
}

resource "aws_dx_hosted_public_virtual_interface" "hosted_public_vif" {
  count = var.create_hosted_public_vif ? 1 : 0

  name                 = "${var.environment}-hosted-public-vif"
  connection_id        = var.hosted_connection_id
  vlan                 = var.hosted_vlan
  address_family       = "ipv4"
  bgp_asn              = var.bgp_asn
  customer_address     = var.customer_address
  mtu                  = var.hosted_vif_mtu
  owner_account_id     = var.hosted_owner_account_id
  amazon_address       = var.amazon_address
  virtual_interface_id = var.existing_virtual_interface_id

  route_filter_prefixes = var.advertise_prefixes

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-hosted-public-vif"
    "Type"        = "HostedPublic"
    "Environment" = var.environment
  })
}

resource "aws_dx_lag" "dx_lag" {
  count = var.create_lag ? 1 : 0

  name                  = "${var.environment}-dx-lag"
  connections_bandwidth = var.lag_bandwidth
  location              = var.dx_location
  provider              = var.aws_provider
  number_of_connections = var.lag_connection_count
  force_destroy         = var.lag_force_destroy

  tags = merge(local.dx_tags, {
    "Name"        = "${var.environment}-dx-lag"
    "Type"        = "LAG"
    "Environment" = var.environment
  })

  timeouts {
    create = var.connection_timeout
    delete = var.connection_timeout
  }
}

resource "aws_dx_connection_association" "lag_association" {
  count = var.create_lag && var.lag_associate_connection_count > 0 ? var.lag_associate_connection_count : 0

  virtual_interface_id = var.create_private_vif ? aws_dx_private_virtual_interface.private_vif[count.index].id : aws_dx_public_virtual_interface.public_vif[count.index].id
  connection_id        = aws_dx_lag.dx_lag[0].id
}
# ==============================================================================
# Configuración Principal de Networking - Landing Zone Multi-Cuenta
# ==============================================================================
# Este archivo orquesta la creación de los componentes principales de red:
# VPC principal, subredes, Transit Gateway, VPN redundantes, Direct Connect
# y NAT Gateway para salida a Internet.
# ==============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ==============================================================================
# MÓDULO: VPC PRINCIPAL Y SUBNETS
# ==============================================================================
# Crea la VPC principal con su esquema de direccionamiento CIDR.
# Genera subredes públicas y privadas en múltiples AZs para alta disponibilidad.
# ==============================================================================

module "networking" {
  source = "./modules/networking"

  # Identificadores y etiquetas
  environment           = var.environment
  project_name          = var.project_name
  tags                  = var.common_tags

  # Configuración de CIDR
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs

  # Configuración de disponibilidad
  availability_zones    = var.availability_zones
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway

  # DNS y opciones de VPC
  enable_dns_hostnames = true
  enable_dns_support   = true

  providers = {
    aws = aws
  }
}

# ==============================================================================
# MÓDULO: TRANSIT GATEWAY
# ==============================================================================
# Crea un Transit Gateway para interconectar VPCs, conexiones VPN y Direct Connect.
# Configura attachments para cada VPC y permite enrutamiento centralizado.
# ==============================================================================

module "transit_gateway" {
  source = "./modules/transit_gateway"

  # Identificadores
  environment  = var.environment
  project_name = var.project_name
  tags         = var.common_tags

  # Configuración del Transit Gateway
  tgw_asn                 = var.tgw_asn
  enable_auto_route       = var.tgw_auto_route
  enable_dns_support      = true
  enable_ecmp             = var.enable_ecmp
  default_route_table_association = true
  default_route_table_propagation = true

  # Tags específicos para categorización
  tgw_category = "core-networking"

  providers = {
    aws = aws
  }
}

# ==============================================================================
# ASOCIACIONES DEL TRANSIT GATEWAY CON VPCS
# ==============================================================================
# Asocia la VPC principal y otras VPCs al Transit Gateway para permitir
# comunicación entre ellas a través del núcleo de red.
# ==============================================================================

resource "aws_ec2_transit_gateway_vpc_attachment" "main_vpc_attachment" {
  provider = aws

  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids

  options {
    dns_support                   = "enable"
    ipv6_support                  = "disable"
    appliance_mode_support        = "disable"
    security_group_referencing_support = "enable"
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-tgw-attachment-main-vpc"
    Description = "Attachment de VPC principal al Transit Gateway"
    Component   = "transit-gateway"
    Environment = var.environment
  })
}

# Attachment para VPCs adicionales definidas en el mapa de attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "additional_vpcs" {
  provider = aws

  for_each = var.additional_vpc_attachments

  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  options {
    dns_support                   = "enable"
    ipv6_support                  = "disable"
    appliance_mode_support        = "disable"
    security_group_referencing_support = "enable"
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-tgw-attachment-${each.key}"
    Description = "Attachment de ${each.key} al Transit Gateway"
    Component   = "transit-gateway"
    Environment = var.environment
  })
}

# ==============================================================================
# MÓDULO: VPN REDUNDANTES (ALTA DISPONIBILIDAD)
# ==============================================================================
# Crea conexiones VPN redundantes hacia on-premise mediante dos túneles.
# Implementa VPN primaria y secundaria para resiliencia.
# ==============================================================================

module "vpn" {
  source = "./modules/vpn"

  # Identificadores
  environment  = var.environment
  project_name = var.project_name
  tags         = var.common_tags

  # Conexión al Transit Gateway
  transit_gateway_id = module.transit_gateway.transit_gateway_id

  # Configuración de VPN
  customer_gateway_ip   = var.customer_gateway_ip
  customer_gateway_bgp_asn = var.customer_gateway_bgp_asn

  # Habilitar redundancia
  enable_redundancy = true
  vpn_type          = "ipsec.1"

  providers = {
    aws = aws
  }
}

# ==============================================================================
# MÓDULO: DIRECT CONNECT
# ==============================================================================
# Configura conexión dedicada hacia on-premise mediante AWS Direct Connect.
# Soporta múltiples conexiones para redundancia y mayor ancho de banda.
# ==============================================================================

module "direct_connect" {
  source = "./modules/direct_connect"

  # Identificadores
  environment  = var.environment
  project_name = var.project_name
  tags         = var.common_tags

  # Conexión al Transit Gateway
  transit_gateway_id = module.transit_gateway.transit_gateway_id

  # Configuración de Direct Connect
  dx_connection_name     = var.dx_connection_name
  dx_bandwidth           = var.dx_bandwidth
  dx_location            = var.dx_location
  dx_vlan                = var.dx_vlan
  enable_private_virtual_interface = true
  enable_public_virtual_interface  = false

  providers = {
    aws = aws
  }
}

# ==============================================================================
# RUTAS DEL TRANSIT GATEWAY
# ==============================================================================
# Configura las tablas de rutas del Transit Gateway para dirigir tráfico
# entre VPCs, VPN y Direct Connect de manera controlada.
# ==============================================================================

resource "aws_ec2_transit_gateway_route" "vpc_to_vpn" {
  provider = aws

  transit_gateway_route_table_id = module.transit_gateway.default_route_table_id
  destination_cidr_block         = var.on_premise_cidr
  transit_gateway_attachment_id  = module.vpn.vpn_attachment_id
}

resource "aws_ec2_transit_gateway_route" "vpc_to_direct_connect" {
  provider = aws

  for_each = toset(var.on_premise_networks)

  transit_gateway_route_table_id = module.transit_gateway.default_route_table_id
  destination_cidr_block         = each.value
  transit_gateway_attachment_id  = module.direct_connect.dx_gateway_attachment_id
}

resource "aws_ec2_transit_gateway_route" "vpc_to_additional_vpcs" {
  provider = aws

  for_each = aws_ec2_transit_gateway_vpc_attachment.additional_vpcs

  transit_gateway_route_table_id = module.transit_gateway.default_route_table_id
  destination_cidr_block         = var.additional_vpc_attachments[each.key].cidr
  transit_gateway_attachment_id  = each.value.id
}

# ==============================================================================
# RUTAS DE LA VPC PRINCIPAL
# ==============================================================================
# Configura rutas en la tabla de rutas de la VPC para dirigir tráfico
# hacia el Transit Gateway y otras redes conectadas.
# ==============================================================================

resource "aws_route" "vpc_to_transit_gateway" {
  provider = aws

  route_table_id         = module.networking.private_route_table_id
  destination_cidr_block = var.transit_gateway_route_cidr
  transit_gateway_id     = module.transit_gateway.transit_gateway_id
}

resource "aws_route" "vpc_to_on_premise" {
  provider = aws

  route_table_id         = module.networking.private_route_table_id
  destination_cidr_block = var.on_premise_cidr
  transit_gateway_id     = module.transit_gateway.transit_gateway_id
}

# ==============================================================================
# TABLA DE RUTAS PÚBLICA PARA NAT GATEWAY
# ==============================================================================
# Permite que las instancias en subredes privadas salgan a Internet
# a través del NAT Gateway.
# ==============================================================================

resource "aws_route" "private_to_nat_gateway" {
  provider = aws

  route_table_id         = module.networking.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.networking.nat_gateway_id
}

# ==============================================================================
# SECURITY GROUPS DE RED
# ==============================================================================
# Grupos de seguridad para gestión y acceso a componentes de red.
# ==============================================================================

resource "aws_security_group" "network_management" {
  provider = aws

  name        = "${var.project_name}-${var.environment}-network-management"
  description = "Security group para acceso de gestión a componentes de red"
  vpc_id      = module.networking.vpc_id

  ingress {
    description = "SSH desde red de gestión"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.management_cidr]
  }

  ingress {
    description = "HTTPS desde red de gestión"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.management_cidr]
  }

  egress {
    description = "Salida a Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-sg-network-mgmt"
    Component   = "security-group"
    Environment = var.environment
  })
}

resource "aws_security_group" "inter_vpc" {
  provider = aws

  name        = "${var.project_name}-${var.environment}-inter-vpc"
  description = "Security group para comunicación entre VPCs"
  vpc_id      = module.networking.vpc_id

  ingress {
    description = "Todo el tráfico desde VPCs conectadas"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Salida a Internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-sg-inter-vpc"
    Component   = "security-group"
    Environment = var.environment
  })
}
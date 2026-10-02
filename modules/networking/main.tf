terraform {
  required_version = ">= 1.5"
}

# ===========================================
# VPC PRINCIPAL
# ===========================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-vpc-${var.vpc_name}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "vpc-main"
    }
  )
}

# ===========================================
# INTERNET GATEWAY
# ===========================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-igw"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "internet-gateway"
    }
  )
}

# ===========================================
# ELASTIC IP PARA NAT GATEWAY
# ===========================================
resource "aws_eip" "nat" {
  count  = var.enable_nat_gateway ? var.nat_gateway_count : 0
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-eip-nat-${count.index}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "nat-gateway-eip"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# ===========================================
# NAT GATEWAY
# ===========================================
resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway ? var.nat_gateway_count : 0
  allocation_id = aws_eip_nat[count.index].id
  subnet_id     = aws_subnet.public[var.nat_subnet_azs[count.index] != null ? index(keys(var.nat_subnet_azs), keys(var.nat_subnet_azs)[count.index]) : count.index].id

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-nat-gw-${count.index}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "nat-gateway"
    }
  )

  depends_on = [aws_internet_gateway.main]
}

# ===========================================
# SUBREDES PÚBLICAS
# ===========================================
locals {
  # Calcular subredes públicas basadas en el bloque CIDR de la VPC
  public_subnet cidrs = [for i, az in var.availability_zones : cidrsubnet(var.vpc_cidr, var.subnet_prefix_length, i)]
  
  # Calcular subredes privadas para cada tier
  private_subnet_cidrs = {
    for tier, config in var.private_subnet_tiers :
    tier => [for i, az in var.availability_zones : cidrsubnet(config.cidr_offset, config.subnet_prefix_length, i)]
  }
  
  # Mapear AZs a índices para NAT Gateway
  az_list = var.availability_zones
}

resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-public-subnet-${count.index + 1}-${var.availability_zones[count.index]}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Tier        = "public"
      SubnetType  = "public"
      AZ          = var.availability_zones[count.index]
    }
  )
}

# ===========================================
# SUBREDES PRIVADAS POR TIER
# ===========================================
resource "aws_subnet" "private" {
  # Generar una lista plana de todas las subredes privadas de todos los tiers
  for_each = merge([
    for tier, config in var.private_subnet_tiers :
    {
      for i, az in var.availability_zones :
      "${tier}-${i}" => {
        tier           = tier
        cidr           = config.cidr_offsets[count.index]
        az             = az
        additional_tags = config.additional_tags
      }
    }
  ]...)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(
    var.tags,
    each.value.additional_tags,
    {
      Name        = "${var.environment}-private-${each.value.tier}-subnet-${index(var.availability_zones, each.value.az) + 1}-${each.value.az}"
      Environment = var.environment
      ManagedBy   = "terraform"
      Tier        = each.value.tier
      SubnetType  = "private"
      AZ          = each.value.az
    }
  )
}

# ===========================================
# TABLAS DE RUTAS PÚBLICAS
# ===========================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-public-rt"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "public-route-table"
    }
  )
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ===========================================
# TABLAS DE RUTAS PRIVADAS
# ===========================================
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_tiers)
  vpc_id = aws_vpc.main.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.main[0].id
    }
  }

  # Ruta hacia Transit Gateway si está habilitado
  dynamic "route" {
    for_each = var.transit_gateway_id != null ? [1] : []
    content {
      cidr_block         = var.transit_gateway_route
      transit_gateway_id = var.transit_gateway_id
    }
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-private-${keys(var.private_subnet_tiers)[count.index]}-rt"
      Environment = var.environment
      ManagedBy   = "terraform"
      Purpose     = "private-route-table"
      Tier        = keys(var.private_subnet_tiers)[count.index]
    }
  )
}

# ===========================================
# ASOCIACIONES DE RUTAS PRIVADAS
# ===========================================
resource "aws_route_table_association" "private" {
  # Crear asociación para cada subred privada
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[index(keys(var.private_subnet_tiers), each.value.tags["Tier"])].id
}

# ===========================================
# SECURITY GROUPS BÁSICOS
# ===========================================
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Security group por defecto para la VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Permitir todo el tráfico entrante dentro de la VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Permitir todo el tráfico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-default-sg"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )
}
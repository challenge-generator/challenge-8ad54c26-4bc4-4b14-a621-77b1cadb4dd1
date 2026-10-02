# --------------------------------------------------------------
# Módulo de NAT Gateway para conectividad de salida
# Proporciona NAT para instancias en subredes privadas hacia internet
# Implementa alta disponibilidad mediante NAT Gateways por AZ
# --------------------------------------------------------------

# Asignación de IP elástica para el NAT Gateway
# La EIP persiste incluso si el NAT Gateway se reemplaza
resource "aws_eip" "nat" {
  for_each = toset(var.availability_zones)

  domain = "vpc"
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.naming_prefix}-eip-${each.value}"
      Type        = "nat-gateway-eip"
      Environment = var.environment
      Component   = "networking"
      ManagedBy   = "terraform"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# NAT Gateway principal en cada zona de disponibilidad
# Proporciona conectividad saliente para subredes privadas
# Alta disponibilidad: un NAT Gateway por AZ evita punto único de fallo
resource "aws_nat_gateway" "main" {
  for_each = toset(var.availability_zones)

  allocation_id = aws_eip.nat[each.value].id
  subnet_id     = var.public_subnet_ids[each.value]

  tags = merge(
    var.common_tags,
    {
      Name             = "${var.naming_prefix}-nat-${each.value}"
      Type             = "nat-gateway"
      Environment      = var.environment
      Component        = "networking"
      AvailabilityZone = each.value
      ManagedBy        = "terraform"
    }
  )

  depends_on = [aws_internet_gateway.main]

  lifecycle {
    create_before_destroy = true
  }
}

# Tabla de enrutamiento para subredes privadas
# Todo el tráfico destined a internet (0.0.0.0/0) se dirige al NAT Gateway
# El NAT Gateway traduce la IP origen privada a IP pública del NAT
resource "aws_route_table" "private" {
  for_each = toset(var.availability_zones)

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[each.value].id
  }

  tags = merge(
    var.common_tags,
    {
      Name             = "${var.naming_prefix}-rt-private-${each.value}"
      Type             = "private-route-table"
      Environment      = var.environment
      Component        = "networking"
      AvailabilityZone = each.value
      ManagedBy        = "terraform"
    }
  )
}

# Asociación de subredes privadas con su tabla de rutas
# Cada subred privada en una AZ específica usa el NAT Gateway de esa AZ
# Optimización de tráfico: evita tráfico cross-AZ innecesario
resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.private[each.key].id
}

# Internet Gateway requerido para NAT Gateway
# Proporciona conectividad hacia internet desde la VPC
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.naming_prefix}-igw"
      Type        = "internet-gateway"
      Environment = var.environment
      Component   = "networking"
      ManagedBy   = "terraform"
    }
  )
}

# Ruta pública en tabla de rutas pública para tráfico internet
# Permite que subredes públicas tengan acceso directo a internet
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.naming_prefix}-rt-public"
      Type        = "public-route-table"
      Environment = var.environment
      Component   = "networking"
      ManagedBy   = "terraform"
    }
  )
}

# Asociación de subredes públicas con tabla de rutas pública
resource "aws_route_table_association" "public" {
  for_each = var.public_subnet_ids

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}
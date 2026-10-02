# providers.tf - Configuración del provider de AWS y definición de la versión de Terraform requerida

terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del provider de AWS para la región principal
provider "aws" {
  region = var.regions[0]
  default_tags {
    tags = var.tags
  }
}

# Configuración de providers adicionales para regiones secundarias
provider "aws" {
  alias  = "secondary"
  region = var.regions[1]
  default_tags {
    tags = var.tags
  }
}

# Configuración para habilitar el uso de Transit Gateway entre regiones
provider "aws" {
  alias  = "transit_gateway_peering"
  region = var.regions[0]
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/TransitGatewayPeeringRole"
  }
}

data "aws_caller_identity" "current" {}

# Configuración para habilitar el uso de Direct Connect
provider "aws" {
  alias = "direct_connect"
  region = var.regions[0]
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/DirectConnectRole"
  }
}

# Configuración para habilitar el uso de VPN
provider "aws" {
  alias = "vpn"
  region = var.regions[0]
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/VPNGatewayRole"
  }
}
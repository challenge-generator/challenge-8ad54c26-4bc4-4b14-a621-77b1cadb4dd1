# ==============================================================================
# Configuración del Backend Remoto para Terraform
# ==============================================================================
# Este archivo configura el almacenamiento remoto del estado de Terraform
# utilizando S3 para persistencia y DynamoDB para bloqueo de estado.
# El estado remoto permite colaboración entre equipos y seguridad contra
# modificaciones concurrentes.
# ==============================================================================

terraform {
  backend "s3" {
    # ==============================================================================
    # CONFIGURACIÓN DEL BUCKET S3
    # ==============================================================================
    # Bucket donde se almacena el archivo de estado de Terraform.
    # El nombre del bucket debe ser único globalmente en AWS.
    # ==============================================================================
    bucket = "${var.project_name}-${var.environment}-terraform-state"

    # ==============================================================================
    # CLAVE DEL ESTADO DENTRO DEL BUCKET
    # ==============================================================================
    # Define la ruta dentro del bucket donde se almacena el estado.
    # Permite separar estados por ambiente y componente.
    # ==============================================================================
    key = "networking/terraform.tfstate"

    # ==============================================================================
    # REGIÓN DE AWS
    # ==============================================================================
    # Región donde reside el bucket S3 y la tabla DynamoDB.
    # ==============================================================================
    region = var.aws_region

    # ==============================================================================
    # HABILITAR CIFRADO DEL ESTADO
    # ==============================================================================
    # El estado se cifra automáticamente con SSE-S3 (AES-256).
    # ==============================================================================
    encrypt = true

    # ==============================================================================
    # TABLA DYNAMODB PARA BLOQUEO DE ESTADO
    # ==============================================================================
    # Utiliza DynamoDB para implementar bloqueo preventivo.
    # Evita que múltiples usuarios ejecuten Terraform simultáneamente.
    # ==============================================================================
    dynamodb_table = "${var.project_name}-${var.environment}-terraform-locks"

    # ==============================================================================
    # MODO DE REPLICACIÓN (opcional para producción)
    # ==============================================================================
    # Habilitar replicación entre regiones para recuperación ante desastres.
    # Descomentar si se requiere DR en otra región.
    # ==============================================================================
    # replication_configuration {
    #   replicate = {
    #     region     = "us-east-2"
    #   }
    # }

    # ==============================================================================
    # VERSIÓN DEL ESTADO
    # ==============================================================================
    # Habilita versioning del estado en S3 para auditoría y rollback.
    # ==============================================================================
    # versioned = true
  }
}

# ==============================================================================
# VARIABLES REFERENCIADAS POR EL BACKEND
# ==============================================================================
# Estas variables deben estar disponibles en el archivo terraform.tfvars
# del ambiente correspondiente para que el backend se inicialice correctamente.
# ==============================================================================

variable "project_name" {
  description = "Nombre del proyecto para naming de recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "aws_region" {
  description = "Región primaria de AWS"
  type        = string
}

# ==============================================================================
# NOTA SOBRE INICIALIZACIÓN DEL BACKEND
# ==============================================================================
# Para inicializar este backend, execute:
#   terraform init -backend-config="profile=default"
#
# Si el bucket o la tabla DynamoDB no existen, primero ejecute:
#   terraform init -backend=false
# para obtener el plan inicial, y luego cree los recursos de backend manualmente
# o mediante un módulo de bootstrap.
#
# El estado remoto es CRÍTICO para entornos de producción porque:
# 1. Permite colaboración entre múltiples miembros del equipo
# 2. Proporciona persistencia del estado entre ejecuciones
# 3. Evita conflictos mediante bloqueo con DynamoDB
# 4. Protege contra pérdida de estado local
# 5. Permite auditoría de cambios mediante versioning de S3
# ==============================================================================
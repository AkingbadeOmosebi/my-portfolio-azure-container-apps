# ----------------------------
# Provider
# ----------------------------
provider "azurerm" {
  features {}
}

# ----------------------------
# Resource Group
# ----------------------------
resource "azurerm_resource_group" "rg" {
  name     = "myportfolio-rg"
  location = "westeurope"
}

# ----------------------------
# Container App Environment
# ----------------------------
resource "azurerm_container_app_environment" "env" {
  name                = "myportfolio-env"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# ----------------------------
# Container App
# ----------------------------
resource "azurerm_container_app" "app" {
  name                         = "myportfolio-app"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  # --------------------------
  # Container template
  # --------------------------
  template {
    container {
      name   = "portfolio"
      image  = "194722436853.dkr.ecr.eu-central-1.amazonaws.com/my_portfolio:${var.image_tag}"
      cpu    = 0.5
      memory = "1.0Gi"
    }

    min_replicas = 1
    max_replicas = 3
  }

  # --------------------------
  # Networking (Ingress)
  # --------------------------
  ingress {
    external_enabled = true
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  # --------------------------
  # ECR registry authentication
  # --------------------------
  registry {
    server                = "194722436853.dkr.ecr.eu-central-1.amazonaws.com"
    username              = "AWS"
    password_secret_name  = "ecr-token"
  }

  # Secret dynamically injected from GitHub Actions
  secret {
    name  = "ecr-token"
    value = var.ecr_token
  }
}

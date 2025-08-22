# my Azure Provider bnlock
provider "azurerm" {
  features {}
}

# My resource groupp block
resource "azurerm_resource_group" "rg" {
  name     = "myportfolio-rg"
  location = "westeurope"
}

# container app env block
resource "azurerm_container_app_environment" "env" {
  name                = "myportfolio-env"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# My container app block
resource "azurerm_container_app" "app" {
  name                         = "myportfolio-app"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    container {
      name   = "portfolio"
      image = "194722436853.dkr.ecr.eu-central-1.amazonaws.com/my_portfolio:${var.image_tag}"
      cpu    = 0.5
      memory = "1.0Gi"
    }

    # Scale configuration
    min_replicas = 1
    max_replicas = 2
  }

  # Ingress configuration to allow comms from the internet 
  ingress {
    external_enabled = true
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  # my aws ecr registry auithentication so container app can find it
  registry {
    server   = "194722436853.dkr.ecr.eu-central-1.amazonaws.com"
    username = "AWS"
    password_secret_name = "ecr-token" # Reference to a secret
  }

  # the token created for azure to authenticate into aws ecr and get access to the private image
  secret {
    name  = "ecr-token"
    value = var.ecr_token
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.89.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "murti_resource_group" {
  name     = "ContactBookRG-${random_integer.ri.result}"
  location = "West Europe"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
resource "azurerm_service_plan" "azasp" {
  name                = "contact-book-service-plan-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.murti_resource_group.name
  location            = azurerm_resource_group.murti_resource_group.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
resource "azurerm_linux_web_app" "azlwa" {
  name                = "contact-book-webapp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.murti_resource_group.name
  location            = azurerm_resource_group.murti_resource_group.location
  service_plan_id     = azurerm_service_plan.azasp.id

  site_config {
    application_stack {
      node_version = "16-lts"
    }
    always_on = false
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_source_control
resource "azurerm_app_service_source_control" "github" {
  app_id                 = azurerm_linux_web_app.azlwa.id
  repo_url               = "https://github.com/nakov/ContactBook"
  branch                 = "master"
  use_manual_integration = true
}

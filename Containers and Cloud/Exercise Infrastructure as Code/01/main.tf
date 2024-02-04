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

resource "azurerm_resource_group" "murti_resource_group" {
  name     = "murtirg"
  location = "West Europe"
}
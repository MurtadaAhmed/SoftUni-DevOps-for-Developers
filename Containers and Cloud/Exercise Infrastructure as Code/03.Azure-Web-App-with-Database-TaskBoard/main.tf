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
  name     = "TaskBoardRG${random_integer.ri.result}"
  location = "West Europe"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
resource "azurerm_service_plan" "azasp" {
  name                = "task-board-service-plan-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.murti_resource_group.name
  location            = azurerm_resource_group.murti_resource_group.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
resource "azurerm_linux_web_app" "azlwa" {
  name                = "task-board-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.murti_resource_group.name
  location            = azurerm_resource_group.murti_resource_group.location
  service_plan_id     = azurerm_service_plan.azasp.id
  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.mssql.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.database.name};User ID=${azurerm_mssql_server.mssql.administrator_login};Password=${azurerm_mssql_server.mssql.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }
}





# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_source_control
resource "azurerm_app_service_source_control" "github" {
  app_id                 = azurerm_linux_web_app.azlwa.id
  repo_url               = "https://github.com/MurtadaAhmed/terraformtaskboarddemo"
  branch                 = "main"
  use_manual_integration = true
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
resource "azurerm_mssql_server" "mssql" {
  name                         = "task-board-sql-${random_integer.ri.result}"
  resource_group_name          = azurerm_resource_group.murti_resource_group.name
  location                     = azurerm_resource_group.murti_resource_group.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "database" {
  name           = "TaskBoardDB${random_integer.ri.result}"
  server_id      = azurerm_mssql_server.mssql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "S0"
  zone_redundant = false
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_firewall_rule
resource "azurerm_mssql_firewall_rule" "firewall" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.mssql.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
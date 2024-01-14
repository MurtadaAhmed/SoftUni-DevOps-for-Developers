variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure SQL Database Server."
}

variable "resource_group_location" {
  description = "The location of the resource group in which to create the Azure SQL Database Server."
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan to create."
}

variable "app_service_name" {
  description = "The name of the App Service to create."
}

variable "sql_server_name" {
  description = "The name of the Azure SQL Database Server to create."
}

variable "sql_database_name" {
  description = "The name of the Azure SQL Database to create."
}

variable "sql_administrator_login_username" {
  description = "The username of the Azure SQL Database Server administrator."
}

variable "sql_administrator_password" {
  description = "The password of the Azure SQL Database Server administrator."
}

variable "firwall_rule_name" {
  description = "The name of the Azure SQL Database Server firewall rule to create."
}

variable "repo_URL" {
  description = "The URL of the GitHub repository to deploy."
}
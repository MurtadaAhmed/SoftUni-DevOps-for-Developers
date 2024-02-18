variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string

}

variable "resource_group_location" {
  description = "The location/region where the resource group will be created."
  type        = string

}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan."
  type        = string

}

variable "app_service_name" {
  description = "app service name"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string

}

variable "sql_server_database_name" {
  description = "The name of the SQL Database."
  type        = string

}

variable "sql_server_username" {
  description = "The username for the SQL Server."
  type        = string

}

variable "sql_server_password" {
  description = "The password for the SQL Server."
  type        = string

}

variable "firewall_name" {
  description = "The name of the SQL Server Firewall Rule."
  type        = string

}

variable "github_repo" {
  description = "the github repo"
  type        = string
}
variable "resource_group_name" {
  type        = string
  description = "name of the resource group name"

}

variable "resource_group_location" {
  type        = string
  description = "location of the resource group"

}

variable "app_service_plan_name" {
  type        = string
  description = "name of the service plan"
}

variable "app_service_name" {
  type        = string
  description = "name of the app service"

}

variable "sql_server_name" {
  type        = string
  description = "name of the sql server"

}

variable "sql_database_name" {
  type        = string
  description = "name of the sql database"

}

variable "sql_admin_login" {
  type        = string
  description = "admin username for the sql server"

}

variable "sql_admin_password" {
  type        = string
  description = "admin password for the sql server"

}

variable "firewall_rule_name" {
  type        = string
  description = "name of the firewall rule"

}

variable "repo_URL" {
  type        = string
  description = "URL of the repository"
}
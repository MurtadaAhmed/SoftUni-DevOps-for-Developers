output "azurerm_linux_web_app" {
  value = azurerm_linux_web_app.alwa.default_hostname
}

output "webapp_ips" {
  value = azurerm_linux_web_app.alwa.outbound_ip_addresses

}
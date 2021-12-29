output "ip-ids" {
  value = azurerm_public_ip.ip[*].id
}

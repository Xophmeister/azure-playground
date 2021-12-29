output "subnet" {
  value = azurerm_subnet.subnet.id
}

output "public-ip-ids" {
  value = azurerm_public_ip.ip[*].id
}

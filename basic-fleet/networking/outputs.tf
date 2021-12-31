output "subnet" {
  value = azurerm_subnet.subnet.id
}

output "public-ip" {
  value = azurerm_public_ip.ip[*].id
}

output "security-group" {
  value = module.security.id
}

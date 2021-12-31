resource "azurerm_network_security_group" "group" {
  name                = "${var.name}-group"
  location            = var.group.location
  resource_group_name = var.group.name
}

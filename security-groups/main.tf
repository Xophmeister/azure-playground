resource "azurerm_network_security_group" "secgroup" {
  name                = "${var.name}-secgroup"
  location            = var.group.location
  resource_group_name = var.group.name
}

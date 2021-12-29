resource "azurerm_network_security_rule" "ssh-in" {
  name                        = "${azurerm_network_security_group.secgroup.name}-ssh-in"
  resource_group_name         = var.group.name
  network_security_group_name = azurerm_network_security_group.secgroup.name

  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

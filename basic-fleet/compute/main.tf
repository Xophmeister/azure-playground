resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  location            = var.group.location
  resource_group_name = var.group.name

  ip_configuration {
    name                          = "${var.name}-nic-ipconfig"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public-ip
  }
}

resource "azurerm_network_interface_security_group_association" "nic-secgroup" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.security-group
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.name}-vm"
  location            = var.group.location
  resource_group_name = var.group.name

  size = var.size

  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_username = "azure"
  admin_ssh_key {
    username   = "azure"
    public_key = file(var.public-key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

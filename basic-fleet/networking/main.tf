## Virtual Network #####################################################

resource "azurerm_virtual_network" "network" {
  name                = "${var.name}-network"
  location            = var.group.location
  resource_group_name = var.group.name

  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}-subnet"
  resource_group_name  = var.group.name
  virtual_network_name = azurerm_virtual_network.network.name

  address_prefixes     = ["10.0.1.0/24"]
}

## Public IPs ##########################################################

resource "azurerm_public_ip" "ip" {
  name                = "${var.name}-ip-${format("%02d", count.index + 1)}"
  location            = var.group.location
  resource_group_name = var.group.name
  allocation_method   = "Dynamic"

  count               = var.ip-count
}

## Network Security (Firewall) #########################################

module "security" {
  source = "./security"
  name   = "${var.name}-security"
  group  = var.group
}

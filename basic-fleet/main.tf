provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "group" {
  name     = var.prefix
  location = var.location
}

module "network" {
  source = "./networking"
  name   = "${var.prefix}-networking"
  group  = azurerm_resource_group.group
}

module "fleet" {
  source = "./compute"
  name   = "${var.prefix}-compute-${format("%02d", count.index + 1)}"
  group  = azurerm_resource_group.group

  subnet         = module.network.subnet
  public-ip      = module.network.public-ip[count.index]
  security-group = module.network.security-group
  public-key     = var.public-key
  size           = var.machine-size

  count = var.instances
}

output "instances" {
  value = module.fleet[*].instance
}

provider "azurerm" {
  features {}
}

## Resource Group ######################################################

resource "azurerm_resource_group" "group" {
  name     = var.prefix
  location = var.location
}

## Networking ##########################################################

module "network" {
  source = "./network"
  name   = "${var.prefix}-network"
  group  = azurerm_resource_group.group
}

module "security-group" {
  source = "./security-groups"
  name   = "${var.prefix}-firewall"
  group  = azurerm_resource_group.group
}

## Compute #############################################################

module "instance" {
  source = "./instance"
  name   = "${var.prefix}-instance-${format("%02d", count.index + 1)}"
  group  = azurerm_resource_group.group

  subnet         = module.network.subnet
  public-ip      = module.network.public-ip-ids[count.index]
  security-group = module.security-group.id
  public-key     = var.public-key

  size = "Standard_DS1_v2"

  count = var.instances
}

## Outputs #############################################################

output instances {
  value = module.instance[*].instance
}

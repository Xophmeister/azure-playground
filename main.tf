provider "azurerm" {
  features {}
}

## Resource Group ######################################################

resource "azurerm_resource_group" "group" {
  name     = "resource-group"
  location = var.location
}

## Networking ##########################################################

module "network" {
  source = "./network"
  name   = "network"
  group  = azurerm_resource_group.group
}

module "security-groups" {
  source = "./security-groups"
  name   = "firewall"
  group  = azurerm_resource_group.group
}

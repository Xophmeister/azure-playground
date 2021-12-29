output instance {
  value = {
    name = azurerm_linux_virtual_machine.vm.name
    ip   = azurerm_linux_virtual_machine.vm.public_ip_address
  }
}

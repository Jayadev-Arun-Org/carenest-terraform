output "bastion_host_name" {
  value       = azurerm_bastion_host.bastion.name
  description = "The name of the Bastion Host"
}

output "jumpbox_private_ip" {
  value       = azurerm_linux_virtual_machine.jumpbox.private_ip_address
  description = "The private IP address of the Jumpbox VM"
}

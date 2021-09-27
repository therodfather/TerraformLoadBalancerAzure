resource "azurerm_network_interface" "hatestnic" {
  count                           = 2
	name                            = "hatestnic${count.index}"
# location                        = "${data.azurerm_resource_group.example.location}"
# resource_group_name             = "${data.azurerm_resource_group.example.name}"
  location                        = azurerm_resource_group.example.location
  resource_group_name             = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "testconfiguration1"
#   subnet_id                     = "${data.azurerm_subnet.subnet1.id}"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Static"
		private_ip_address            = "172.16.240.${count.index+6}"
  }
}

resource "azurerm_virtual_machine" "hatest" {
	count                 = 2
	name                  = "hatest${count.index}"
# location              = "${data.azurerm_resource_group.example.location}"
#	resource_group_name   = "${data.azurerm_resource_group.example.name}"
	location              = azurerm_resource_group.example.location
	resource_group_name   = azurerm_resource_group.example.name
	network_interface_ids = [azurerm_network_interface.hatestnic[count.index].id]
	vm_size               = "Standard_F8s_v2"
	availability_set_id   =  azurerm_availability_set.set1.id
	delete_os_disk_on_termination = true
	delete_data_disks_on_termination = true
	
  storage_image_reference {
    publisher = "loadbalancer"
    offer     = "loadbalancer-org-load-balancer-for-azure"
    sku       = "max_load_balancer"
    version   = "latest"
  }

	plan {
    name      = "max_load_balancer"
    publisher = "loadbalancer"
    product   = "loadbalancer-org-load-balancer-for-azure"
  }

  storage_os_disk {
    name              = azurerm_network_interface.hatestnic[count.index].name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
# You must insert your own Password on line 54 in between the quotations, this password MUST conform to Azure standards or it will fail. Also, passwords are never to be in plain text in prod. Please use a keyvault variable to call this credential if using in production or outside of testing. 
  os_profile {
    computer_name  = azurerm_network_interface.hatestnic[count.index].name
    admin_username = "lbadmin"
    admin_password = ""
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Production"
  }
}
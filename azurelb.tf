# If using data source blocks for existing resources, uncomment the parameters in each block, then comment out the ones that do no use data sources.
resource "azurerm_lb" "lb1" {
  name                = "TestLoadBalancer"
# location            = "${data.azurerm_resource_group.example.location}"
# resource_group_name = "${data.azurerm_resource_group.example.name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                            = "FEIP1"
    private_ip_address_allocation   = "Static"
		private_ip_address              = "172.16.245.240"
#		subnet_id                       = "${data.azurerm_subnet.subnet2.id}"
    subnet_id                       = azurerm_subnet.subnet2.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend1" {
  loadbalancer_id = azurerm_lb.lb1.id
  name            = "Test-Pool"
}

resource "azurerm_network_interface_backend_address_pool_association" "associate1" {
  count                   = 2
	network_interface_id    = azurerm_network_interface.hatestnic[count.index].id
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend1.id
}

resource "azurerm_lb_rule" "lbrule1" {
# resource_group_name            = "${data.azurerm_resource_group.example.name}"
  resource_group_name            = azurerm_resource_group.example.name
  loadbalancer_id                = azurerm_lb.lb1.id
  name                           = "LBRule"
  protocol                       = "All"
	backend_address_pool_id        = azurerm_lb_backend_address_pool.backend1.id
  frontend_port                  = "0"
  backend_port                   = "0"
  frontend_ip_configuration_name = "FEIP1"
	idle_timeout_in_minutes        = "15"
	probe_id                       = azurerm_lb_probe.probe1.id
}

resource "azurerm_lb_probe" "probe1" {
# resource_group_name = "${data.azurerm_resource_group.hosted_rg_prod.name}"
  resource_group_name = azurerm_resource_group.example.name
  loadbalancer_id     = azurerm_lb.lb1.id
  name                = "Example-Probe"
	protocol            = "Http"
  port                = "6694"
	request_path        = "/"
	interval_in_seconds = "5"
}
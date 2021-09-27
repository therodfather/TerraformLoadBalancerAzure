resource "azurerm_availability_set" "set1" {
  name                = "aset1"
# location            = "${data.azurerm_resource_group.example.location}"
# resource_group_name = "${data.azurerm_resource_group.example.name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    environment = "Production"
  }
}
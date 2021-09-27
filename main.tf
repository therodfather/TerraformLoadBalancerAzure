#Use the block below if you have an existing statefile you plan to use in Azure.
#terraform {
#  backend "azurerm" {}
#  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = "=2.50.0"
#    }
#  }
#}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# Use this block if you have an existing Resource group you want to use. Just add the name in the quotations on line 20.
# data "azurerm_resource_group" "example" {
# 	name = ""
# }

# This will create a resource group for you to use.
resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "East US"
}

# Use this block if you have an existing vnet you want to use. Just add the name of the vnet in the quotations on line 31.
# data "azurerm_virtual_network" "example" {
#   name                = ""
#   resource_group_name = "${data.azurerm_resource_group.example.name}"
# }

# Use the next 2 blocks if you have existing subnets you want to use. Just add the names of the subnets in the quotations on lines 37 and 43.
# data "azurerm_subnet" "subnet1" {
#   name                 = ""
#   virtual_network_name = "${data.azurerm_virtual_network.example.name}"
#   resource_group_name  = "${data.azurerm_resource_group.example.name}"
# }

# data "azurerm_subnet" "subnet2" {
#   name                 = ""
#   virtual_network_name = "${data.azurerm_virtual_network.example.name}"
#   resource_group_name  = "${data.azurerm_resource_group.example.name}"
# }

# This will create an Azure Vnet and 2 subnets for you to use.
resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["172.16.240.0/20"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.16.240.0/27"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["172.16.245.0/24"]
}
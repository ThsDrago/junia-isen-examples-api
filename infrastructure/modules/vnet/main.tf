resource "azurerm_virtual_network" "my_vnet" {
  name                = "my-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space  # Changement ici de vnet_address_space à address_space
}

resource "azurerm_subnet" "my_subnet" {
  name                 = "my-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = var.subnet_address_prefixes  # Changement ici de subnet_address_prefixes à address_prefixes
}

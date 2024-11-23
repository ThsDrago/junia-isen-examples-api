resource "azurerm_virtual_network" "vnet" {
  name                = "ccp-vnet-${var.random_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space 
}

resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = "ccp-appGatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]  # Ajuste l'adresse selon ton réseau
}


resource "azurerm_subnet" "subnet" {
  name                 = "ccp-subnet-${var.random_suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

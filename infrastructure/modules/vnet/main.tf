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

resource "azurerm_subnet" "app_service_subnet" {
  name                 = "ccp-appServiceSubnet-${var.random_suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]  
  service_endpoints    = ["Microsoft.Web"]  

  # Optionnel : Délégation pour l'App Service
  delegation {
    name = "appServiceDelegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
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

resource "azurerm_network_security_group" "webapp_nsg" {
  name = "webapp-nsg"
  resource_group_name = var.resource_group_name
  location = var.location

  security_rule {
    name                       = "AllowDbSubnetTraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.4.0/24" # Db subnet
    destination_address_prefix = "10.0.3.0/24" # App subnet
  }
}

resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "AllowAppSubnetTraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "10.0.4.0/24"
  }
}
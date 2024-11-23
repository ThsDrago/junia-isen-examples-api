resource "azurerm_public_ip" "public_ip" {
  name                = "ccp-publicIp"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "gateway" {
  name                = var.gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name="Standard_v2"
    tier="Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "ccp-appGatewayIpConfig"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "ccp-frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "ccp-frontendIpConfig"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  backend_address_pool {
    name = "ccp-backendPool"
  }

  backend_http_settings {
    name                  = "ccp-backendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    path = "/"
    protocol              = "Http"
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "ccp-frontendIpConfig"
    frontend_port_name             = "ccp-frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "ccp-routing-rule"
    rule_type                  = "Basic"
    priority                   = 9
    http_listener_name         = "httpListener"
    backend_address_pool_name  = "ccp-backendPool"
    backend_http_settings_name = "ccp-backendHttpSettings"
  }
}

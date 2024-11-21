resource "azurerm_service_plan" "service_plan" {
  name                = "ccp-service-plan-${var.random_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B3"
}

resource "azurerm_linux_web_app" "web_app" {
  name                = "ccp-web-app-${var.random_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  
  identity {
    type = "SystemAssigned"
  }

  site_config {}

  depends_on = [azurerm_service_plan.service_plan]
}

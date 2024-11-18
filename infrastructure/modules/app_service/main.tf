resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "service_plan" {
  name                = "my-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_app_service" "my_api_service" {
  name                = "my-api-service"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.service_plan.id
}

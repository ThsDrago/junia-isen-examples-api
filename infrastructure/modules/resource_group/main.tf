# This resource creates a resource group in Azure.
resource "azurerm_resource_group" "resource_group" {
    name              = "ccp-resource-group-${var.random_suffix}"
    location          = var.location
}
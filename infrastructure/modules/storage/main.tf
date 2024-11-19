resource "azurerm_storage_account" "blob_storage" {
  name                     = "ccpstorageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.subnet_id]
  }
}

resource "azurerm_storage_container" "blob_container" {
  name                  = "ccp-container"
  storage_account_id  = azurerm_storage_account.blob_storage.id
  container_access_type = "private"
}
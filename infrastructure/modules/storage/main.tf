resource "azurerm_storage_account" "blob_storage" {
  name                     = "ccpstorageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Allow"
    virtual_network_subnet_ids = [var.subnet_id]
  }
}

resource "azurerm_storage_container" "blob_container" {
  name                  = "ccp-container-${var.random_suffix}"
  storage_account_id  = azurerm_storage_account.blob_storage.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "blob_storage" {
  name = "quotes.json"
  # Get the quotes.json file from the modules/storage directory and upload it to the storage account
  source                 = "${path.module}/quotes.json"
  storage_account_name   = azurerm_storage_account.blob_storage.name
  storage_container_name = azurerm_storage_container.blob_container.name
  type                   = "Block"
}




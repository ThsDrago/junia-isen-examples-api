resource "azurerm_storage_account" "blob_storage" {
  name                     = "storageaccount${var.random_suffix}"
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
  name                  = "ccp-container-${var.random_suffix}"
  storage_account_id  = azurerm_storage_account.blob_storage.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "blob_storage_iam" {
  principal_id         = var.principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.blob_storage.id

  depends_on = [azurerm_storage_account.blob_storage]
}
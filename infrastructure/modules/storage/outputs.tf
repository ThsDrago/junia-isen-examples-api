output "blob_storage_account_name" {
  value = azurerm_storage_account.blob_storage.name
}

output "blob_container_name" {
  value = azurerm_storage_container.blob_container.name
}

output "url" {
  value = azurerm_storage_account.blob_storage.primary_blob_endpoint
  description = "Hostname to connect to the storage account"
}
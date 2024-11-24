output "blob_storage_account_name" {
  value = azurerm_storage_account.blob_storage.name
}

output "blob_container_name" {
  value = azurerm_storage_container.blob_container.name
}

output "storage_url" {
  value = azurerm_storage_account.blob_storage.primary_blob_endpoint
  description = "Hostname to connect to the storage account"
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.blob_storage.id
}
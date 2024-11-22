output "blob_storage_account_name" {
  value = azurerm_storage_account.blob_storage.name
}

output "blob_container_name" {
  value = azurerm_storage_container.blob_container.name
}

output "storage_account_url" {
  description = "The URL of the Azure Storage Account"
  value       = azurerm_storage_account.example.primary_blob_endpoint
}
output "postgresql_host" {
  value = azurerm_postgresql_flexible_server.ccp_postgres_server.fqdn
}

output "postgresql_port" {
  value = 5432
}

output "postgresql_db_name" {
  value = azurerm_postgresql_flexible_server_database.ccp_database.name
}

output "postgresql_user" {
  value = azurerm_postgresql_flexible_server.ccp_postgres_server.administrator_login
}
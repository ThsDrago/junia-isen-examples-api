resource "azurerm_postgresql_flexible_server" "ccp_postgres_server" {
  name                          = "ccp-postgres-server-${var.random_suffix}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "16"
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.ccp_dns_zone.id
  administrator_login           = "ccpadmin"
  administrator_password        = "admin"
  zone                          = "1"
  sku_name                      = "GP_Standard_D2s_v3"
  storage_mb                    = 32768
  backup_retention_days         = 7
  public_network_access_enabled = false
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.ccp_dns_zone_link]
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "ccp_firewall" {
  name                        = "ccp-firewall-${var.random_suffix}"
  server_id                   = azurerm_postgresql_flexible_server.ccp_postgres_server.id
  start_ip_address            = "10.0.3.0"
  end_ip_address              = "10.0.3.255"
}

resource "azurerm_private_dns_zone" "ccp_dns_zone" {
  name                = "ccp.postgres.database.azure.com"
  resource_group_name = var.resource_group_name 
}

resource "azurerm_private_dns_zone_virtual_network_link" "ccp_dns_zone_link" {
  name                  = "ccp-dns-zone-link-${var.random_suffix}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.ccp_dns_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_postgresql_flexible_server_database" "ccp_database" {
  name      = "ccp-database-${var.random_suffix}"
  server_id = azurerm_postgresql_flexible_server.ccp_postgres_server.id
  collation = "en_US.utf8"
  charset   = "UTF8"
}
resource "random_string" "common" {
  length  = 6
  special = false
  upper   = false
}

# Module resource_group
module "resource_group" {
  source        = "./modules/resource_group"
  location      = var.location
  random_suffix = random_string.common.result
}

# Module vnet (Dépend de resource_group)
module "vnet" {
  source                  = "./modules/vnet"
  resource_group_name     = module.resource_group.resource_group_name
  location                = var.location
  vnet_address_space      = var.vnet_address_space 
  subnet_address_prefixes = var.subnet_address_prefixes
  random_suffix           = random_string.common.result

  depends_on              = [module.resource_group]
}

# Module database (Dépend de vnet et resource_group)
module "database" {
  source              = "./modules/database"
  resource_group_name = module.resource_group.resource_group_name
  vnet_id             = module.vnet.vnet_id
  location            = var.location
  subnet_id           = module.vnet.subnet_id
  random_suffix       = random_string.common.result

  depends_on          = [module.vnet]
}

# Module storage (Dépend de resource_group et vnet)
module "storage" {
  source               = "./modules/storage"
  resource_group_name  = module.resource_group.resource_group_name
  location             = var.location
  subnet_id            = module.vnet.subnet_id
  random_suffix        = random_string.common.result

  depends_on           = [module.resource_group, module.vnet]
}

# Module app_service (Dépend de resource_group, database et storage)
module "app_service" {
  source              = "./modules/app_service"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  web_app_name        = var.web_app_name
  random_suffix       = random_string.common.result
  subnet_id     = module.vnet.subnet_id
  # Passer les paramètres de base de données
  database_host       = module.database.postgresql_host
  database_port       = module.database.postgresql_port
  database_name       = module.database.postgresql_db_name
  database_user       = var.administrator_login
  database_password   = var.administrator_password

  # Passer les paramètres de stockage
  storage_url         = module.storage.storage_url
  storage_account_id  = module.storage.storage_account_id

  app_service_subnet_id   = module.vnet.app_service_subnet_id

  docker_image             = var.docker_image
  docker_registry_url      = var.docker_registry_url
  docker_registry_password = var.docker_registry_password
  docker_registry_username = var.docker_registry_username
  
  depends_on          = [module.database, module.storage]
}

# Module gateway (Dépend de vnet)
module "gateway" {
  source              = "./modules/gateway"
  gateway_name        = var.gateway_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  subnet_id           = module.vnet.app_gateway_subnet_id

  depends_on          = [module.vnet]
}

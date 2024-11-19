module "resource_group" {
    source              = "./modules/resource_group"
    location            = var.location
    resource_group_name = var.resource_group_name
}

module "vnet" {
  source                   = "./modules/vnet"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  vnet_address_space       = var.vnet_address_space 
  subnet_address_prefixes  = var.subnet_address_prefixes

  depends_on = [module.resource_group]
}

module "database" {
  source              = "./modules/database"
  resource_group_name = var.resource_group_name
  vnet_id             = module.vnet.vnet_id
  location            = var.location
  subnet_id           = module.vnet.subnet_id

  depends_on = [module.resource_group]
}

/*
module "web_app" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [module.service_plan]
}

module "service_plan" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = var.resource_group_name
}
*/
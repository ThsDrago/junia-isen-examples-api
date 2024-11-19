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
}




/*

module "web_app" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "service_plan" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = var.resource_group_name
}

*/

module "resource_group" {
    source            = "./modules/app_service"
    location          = var.location
    resource_group_name = var.resource_group_name
}

module "app_service" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "service_plan" {
  source              = "./modules/app_service"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "vnet" {
  source              = "./modules/vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
}


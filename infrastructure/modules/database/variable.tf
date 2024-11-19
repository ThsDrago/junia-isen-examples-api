variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "vnet_id" {
    description = "The id of the vnet"
    type        = string
}

variable "subnet_id" {
    description = "The id of the vnet"
    type        = string
}
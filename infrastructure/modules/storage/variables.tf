variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "subnet_id" {
    description = "The id of the vnet"
    type        = string
}

variable "role_definition_name" {
  description = "Nom du rôle Azure RBAC à attribuer"
  type        = string
  default     = "Storage Blob Data Contributor"
}

variable "principal_id" {
  description = "The principal ID of the managed identity from the App Service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "web_app_name" {
  description = "The name of the web app"
  type        = string
}

variable "random_suffix" {
  description = "Suffixe aléatoire pour les noms des ressources"
  type        = string
}
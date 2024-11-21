variable "location" {
  description = "The Azure region to deploy to"
  type        = string
}

variable "random_suffix" {
  description = "Suffixe aléatoire pour les noms des ressources"
  type        = string
}
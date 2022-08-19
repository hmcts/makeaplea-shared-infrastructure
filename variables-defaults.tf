# Variables with default values or values specified in an {env}.tfvars file

variable "location" {
  default = "UK South"
}

variable "common_tags" {
  type = map(string)
}

# Database

variable "db_storage_mb" {
  default = "5120"
}

variable "product" {
  default = "makeaplea"
}

variable "component" {
    default = "mirror-gateway"
}

variable "db_version" {
  default = 11
}

variable "db_postgresql_user" {
  default = "makeaplea_mirror_gateway_postgresql_user"
}

# Keyvault
variable "product_group_name" {
  default = "dcd_group_pet_v2"
}
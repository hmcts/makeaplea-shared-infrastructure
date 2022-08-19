terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}"
  location = var.location
  tags     = var.common_tags
}
# sandbox environmnet
provider "azurerm" {
  subscription_id = "a8140a9e-f1b0-481f-a4de-09e2ee23f7ab"
  alias           = "sds-sbox"
  features {}
  
}
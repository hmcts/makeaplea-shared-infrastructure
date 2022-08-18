provider "azurerm" {
  features {}
}

locals {
  app = "makeaplea-mirror-gateway"
  shared_infra_rg = "${var.product}-shared-infrastructure-${var.env}"
  vault_name = "${var.product}si-${var.env}"
}

data "azurerm_key_vault" "key_vault" {
  name                = local.vault_name
  resource_group_name = local.shared_infra_rg
}

resource "azurerm_key_vault_secret" "POSTGRES-USER" {
  name         = "makeaplea-mirror-gateway-POSTGRES-USER"
  value        = module.makeaplea-mirror-gateway-db.user_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "POSTGRES-PASS" {
  name         = "makeaplea-mirror-gateway-POSTGRES-PASS"
  value        = module.makeaplea-mirror-gateway-db.postgresql_password
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "POSTGRES_HOST" {
  name         = "makeaplea-mirror-gateway-POSTGRES-HOST"
  value        = module.makeaplea-mirror-gateway-db.host_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "POSTGRES_PORT" {
  name         = "makeaplea-mirror-gateway-POSTGRES-PORT"
  value        = module.makeaplea-mirror-gateway-db.postgresql_listen_port
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "POSTGRES_DATABASE" {
  name         = "makeaplea-mirror-gateway-POSTGRES-DATABASE"
  value        = module.makeaplea-mirror-gateway-db.postgresql_database
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_subnet" "postgres" {
  name                 = "iaas"
  resource_group_name  = "ss-${var.env}-network-rg"
  virtual_network_name = "ss-${var.env}-vnet"
}

module "makeaplea-mirror-gateway-db" {
  source             = "git@github.com:hmcts/cnp-module-postgres?ref=master"
  product            = var.product
  component          = var.component
  location           = var.location
  env                = var.env
  database_name      = "marketplea"
  postgresql_user    = "marketplea"
  postgresql_version = "10"
  sku_name           = "GP_Gen5_2"
  sku_tier           = "GeneralPurpose"
  common_tags        = var.common_tags
  subscription       = var.subscription
  business_area      = "SDS"
}
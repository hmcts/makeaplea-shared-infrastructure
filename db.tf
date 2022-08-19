module "makeaplea-mirror-gateway-database" {
  source             = "git@github.com:hmcts/cnp-module-postgres?ref=postgresql_tf"
  product            = var.product
  component          = ""
  location           = var.location
  env                = var.env
  postgresql_user    = var.db_postgresql_user
  database_name      = var.product
  postgresql_version = var.db_version
  common_tags        = var.common_tags
  subscription       = var.subscription
  storage_mb         = var.db_storage_mb
  business_area      = "SDS"
  key_vault_rg       = "genesis-rg"
  key_vault_name     = "dtssharedservices${var.env}kv"
  subnet_id          = data.azurerm_subnet.postgres.id
}

data "azurerm_subnet" "postgres" {
  name                 = "iaas"
  resource_group_name  = "ss-${var.env}-network-rg"
  virtual_network_name = "ss-${var.env}-vnet"
}

resource "azurerm_key_vault_secret" "makeaplea-mirror-gateway-postgres-user-name" {
  name         = "makeaplea-mirror-gateway-postgres-user-name"
  value        = module.makeaplea-mirror-gateway-database.user_name
  key_vault_id = module.makeaplea-mirror-gateway-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "makeaplea-mirror-gateway-postgres-password" {
  name         = "makeaplea-mirror-gateway-postgres-password"
  value        = module.makeaplea-mirror-gateway-database.postgresql_password
  key_vault_id = module.makeaplea-mirror-gateway-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "makeaplea-mirror-gateway-postgres-host-name" {
  name         = "makeaplea-mirror-gateway-postgres-host-name"
  value        = module.makeaplea-mirror-gateway-database.host_name
  key_vault_id = module.makeaplea-mirror-gateway-key-vault.key_vault_id
}


resource "azurerm_key_vault_secret" "makeaplea-mirror-gateway-postgres-database" {
  name         = "makeaplea-mirror-gateway-postgres-database"
  value        = module.makeaplea-mirror-gateway-database.postgresql_database
  key_vault_id = module.makeaplea-mirror-gateway-key-vault.key_vault_id
}
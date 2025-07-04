data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg-kv" {
  name     = var.resource_group_name
  location = var.location_name
}

resource "azurerm_key_vault" "kv" {
  name                       = var.key_vault_name
  location                   = var.location_name
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver_name
  resource_group_name          = var.resource_group_name
  location                     = var.location_name
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.userid.value
  administrator_login_password = data.azurerm_key_vault_secret.password.value
 }
output "server_id" {
  value = azurerm_mssql_server.sqlserver.id
}
data "azurerm_key_vault" "kv" {
  name                = "rajnish-kv"
  resource_group_name = "rg-todo1988"
}
data "azurerm_key_vault_secret" "userid"{
  name = "administrator-login"
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "password" {
  name         = "administrator-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}
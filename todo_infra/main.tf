module "resource_group_name" {
  source              = "../module/azurerm_resource_group"
  resource_group_name = "rg-todo1988"
  location_name       = "west us"
}
# bhai ye upload krna hai
bhai hindi me ek kahani likhna short me
module "vnet" {
  source              = "../module/azurerm_vnet"
  depends_on          = [module.resource_group_name]
  vnet_name           = "vnet-todo"
  location_name       = "west us"
  resource_group_name = "rg-todo"
  address_space_name  = ["10.0.0.0/16"]
}
module "subnet" {
  source                = "../module/azurerm_subnet"
  depends_on            = [module.vnet]
  subnet_name           = "subnet-todo"
  resource_group_name   = "rg-todo"
  vnet_name             = "vnet-todo"
  address_prefixes_name = ["10.0.0.0/24"]
}
module "pip" {
  source                 = "../module/azurerm_pip"
  pip_name               = "pip-todo"
  location_name          = "west us"
  resource_group_name    = "rg-todo"
  allocation_method_name = "Static"

}
module "vm-todo" {
  source               = "../module/azurerm_virtual_machine"
  depends_on           = [module.subnet]
  resource_group_name  = "rg-todo1988"
  location_name        = "west us"
  vm_name              = "vm-todo"
  size_name            = "Standard_F2"
  # admin_username       = 
  # admin_password       = 
  publisher_name       = "canonical"
  offer_name           = "0001-com-ubuntu-server-jammy"
  sku_name             = "22_04-lts"
  nic_name             = "nic-todo"
  subnet_id_name       = module.subnet.subnet_id
  public_ip_address_id = module.pip.pip_id

}
module "mssql_server"{
  source = "../module/azurerm_mssql_server"
  sqlserver_name = "todo-server101988111"
  resource_group_name = "rg-todo1988"
  location_name = "west us"
  # administrator_login = "Rajnish"
  # administrator_login_password = "R@jnish1988"
}

module "sql_db" {
  source = "../module/azurerm_mssql_database"
  depends_on = [module.mssql_server]
  sql_db_name = "sqldb"
  server_id = module.mssql_server.server_id
}
module "key_vault"{
  source = "../module/azurerm_key_vault"
  resource_group_name = "rg-todo1988"
  location_name = "west us"
  key_vault_name = "Rajnishkitijori"
}
module "userid"{
  source = "../module/azurerm_secret"
  depends_on = [module.key_vault]
  key_vault_name = "Rajnishkitijori"
  resource_group_name = "rg-todo1988"
  secret_name = "user-id"
  secret_value = "Rajnish"
}
module "password"{
  source = "../module/azurerm_secret"
  depends_on = [module.key_vault]
  key_vault_name = "Rajnishkitijori"
  resource_group_name = "rg-todo1988"
  secret_name = "password"
  secret_value = "R@jnish1988"
}





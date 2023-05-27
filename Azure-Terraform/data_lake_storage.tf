#Create a storage account (Data Lake Store Gen 2) for project Vacinacao COVID 19
resource "azurerm_storage_account" "vacinacao" {
  name                     = "vacinacaocovid19"
  resource_group_name      = azurerm_resource_group.vacinacao.name
  location                 = azurerm_resource_group.vacinacao.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"

    tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "vacinacao" {
  count = length(var.containers_name)
  name               = var.containers_name[count.index]
  storage_account_id = azurerm_storage_account.vacinacao.id

  ace {
    type = "other"
    permissions = "rwx"
  }
}


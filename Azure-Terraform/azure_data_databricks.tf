resource "azurerm_databricks_workspace" "vacinacao" {
  name                = "vacinacao_databricks"
  resource_group_name = azurerm_resource_group.vacinacao.name
  #Price is better in Central US but no work
  location            = "Brazil South"
  sku                 = "standard"

  tags = {
    Environment = var.environment
  }
}

#Settings Databricks Notebook:
# 1 - Azure Active Drectory: Need create App resigstration (Use Cliente ID)

# 2 - Scope create https://<databricks-instance>#secrets/createScope

output "azure_databricks_URL" {
  description = "Azure Databricks URL"
  value = azurerm_databricks_workspace.vacinacao
}

# 2.1 - Key vaults:

resource "azurerm_key_vault" "vacinacao" {
  name                        = "vacinacaokeyvault"
  location                    = azurerm_resource_group.vacinacao.location
  resource_group_name         = azurerm_resource_group.vacinacao.name
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id
  }

  tags = {
    Environment = var.environment
  }
}

# 2.2 - Key Vault -> Properties
output "key_vault_properties" {
  description = "Key vault properties Value"
  value = azurerm_key_vault.vacinacao
}
# 2.3 - Key Vault -> Secrets:

# resource "azurerm_key_vault_secret" "vacinacao" {
#   name         = "vacinacao-secret"
#   value        = "secretvault" => Need Value AAD/App registrations
#   key_vault_id = azurerm_key_vault.vacinacao.id
# }

#2.4 - Key Vault -> Directory ID

#3 Endpoint Storage Account - Data Lake Storage

#4 URL Storage Account
# output "storage_account_url" {
#   description = "Storage Account URL"
#   value = azurerm_storage_account.vacinacao.Endpoint
# }


resource "azurerm_data_factory" "vacinacao" {
  name                = "vacinacaodatafactory"
  location            = azurerm_resource_group.vacinacao.location
  resource_group_name = azurerm_resource_group.vacinacao.name

    tags = {
    environment = var.environment
  }
}
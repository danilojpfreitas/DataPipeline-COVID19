#Default Olist Project
# Create a resource group for project Olist
resource "azurerm_resource_group" "vacinacao" {
  name     = "vacinacaocovid"
  location = "East US 2"
}